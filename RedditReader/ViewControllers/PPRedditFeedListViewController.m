//
//  PPRedditFeedListViewController.m
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedListViewController.h"
#import "PPRedditFeedManager.h"
#import "PPRedditFeedCell.h"
#import "PPRedditFeedCell+DataBind.h"
#import "PPSubRedditViewController.h"
#import "PPRedditFeedCollection.h"
#import "PPRedditFeed.h"
#import "PPSubRedditCommentsViewController.h"
#import "PPUtils.h"
#import "PPLoadMoreDataView.h"

@interface PPRedditFeedListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) PPRedditFeedManager *redditFeedManager;
@property (nonatomic, strong) PPRedditFeedCollection *feedCollection;
@property (nonatomic, readwrite) BOOL loadingData;

@end

@implementation PPRedditFeedListViewController

#pragma mark - init

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        _redditFeedManager = [PPRedditFeedManager new];
        self.loadingData = NO;
    }
    
    return self;
}

#pragma mark - UIViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTable];
    [self loadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Hide back button title...cool one! :-)
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    if([segue.identifier isEqualToString:@"feedListToSubRedditSegue"])
    {
        NSIndexPath *indexPathOfSelectedRow = [self.table indexPathForSelectedRow];
        PPRedditFeed *subReddit = self.feedCollection.feeds[indexPathOfSelectedRow.row];
        
        PPSubRedditViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.feed = subReddit;
    }
    else if ([segue.identifier isEqualToString:@"subRedditFeedListToCommentsSegue"])
    {
        UIButton *button = (UIButton*)sender;
        
        CGPoint touchPoint = [button.superview convertPoint:button.center toView:self.table];
        NSIndexPath *indexPathOfSelectedRow = [self.table indexPathForRowAtPoint:touchPoint];
        
        PPRedditFeed *subReddit = self.feedCollection.feeds[indexPathOfSelectedRow.row];
        
        PPSubRedditCommentsViewController *commentsViewController = (PPSubRedditCommentsViewController *)((UINavigationController*)segue.destinationViewController).topViewController;
        commentsViewController.feed = subReddit;
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feedCollection.feeds.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPRedditFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:ppRedditFeedCellIdentifier];
    [cell dataBindWithRedditFeed:self.feedCollection.feeds[indexPath.row ]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL loadingVisible = CGRectIntersectsRect(self.table.bounds,self.table.tableFooterView.frame);
    
    if(loadingVisible && ! IsEmpty(self.feedCollection.after))
    {
        [self loadDataWithSuccessBlock:^{
            [self.table reloadData];
        } failureBlock:^(NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"Can't load more data due to an error."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
            [alertView show];
        }];
    }
}

#pragma mark - Handlers

-(void)retryFailedLoadingGestureRecognizerTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self.view removeGestureRecognizer:gestureRecognizer];

    self.loadingMessageLabel.numberOfLines = 1;
    self.loadingMessageLabel.text = @"Loading data...";

    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    [self loadData];
}

#pragma mark - Helper methods

-(void)setUpTable
{
    self.table.tableFooterView = [[PPLoadMoreDataView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.table.bounds), ppLoadMoreDataViewHeight)];
}

-(void)loadData
{
    [self loadDataWithSuccessBlock:^() {
        
        self.loadingMessageLabel.hidden = YES;
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.table.hidden = NO;
        [self.table reloadData];
        
    } failureBlock:^(NSError *error) {
        
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.loadingMessageLabel.numberOfLines = 2;
        self.loadingMessageLabel.text = @"Could not load data.\nTouch to retry again.";
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retryFailedLoadingGestureRecognizerTap:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        tapGestureRecognizer.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }];
}

/**
 @discussion alters the feedCollection on success. Caller shouldn't do it.
 */
-(void)loadDataWithSuccessBlock:(void(^)(void))successBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    if(! self.loadingData)
    {
        self.loadingData = YES;
        [self.redditFeedManager defaultPageFeedsAfter:self.feedCollection.after
                                         successBlock:^(PPRedditFeedCollection *feedCollection) {
                                             
                                             if(! self.feedCollection)
                                             {
                                                 self.feedCollection = feedCollection;
                                             }
                                             else
                                             {
                                                 self.feedCollection.after = feedCollection.after;
                                                 self.feedCollection.before = feedCollection.before;
                                                 [self.feedCollection.feeds addObjectsFromArray:feedCollection.feeds];
                                             }
                                             
                                             if(successBlock)
                                                 successBlock();
                                             
                                             self.loadingData = NO;
                                             
                                         } failureBlock:^(NSError *error) {
                                             if(failureBlock)
                                                 failureBlock(error);
                                             
                                             self.loadingData = NO;
                                         }];
    }
}

@end
