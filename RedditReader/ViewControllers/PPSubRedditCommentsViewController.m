//
//  PPSubRedditCommentsViewController.m
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPSubRedditCommentsViewController.h"
#import "PPRedditFeed.h"
#import "UIViewController+TwoLineNavBarTitle.h"
#import "PPRedditFeedManager.h"
#import <RATreeView/RATreeView.h>
#import "PPRedditComment.h"
#import "PPSubRedditCommentCell.h"
#import "PPSubRedditCommentCell+DataBind.h"
#import "UIColor+RedditReader.h"

@interface PPSubRedditCommentsViewController () <RATreeViewDataSource, RATreeViewDelegate>

@property (nonatomic, strong, readonly) PPRedditFeedManager *redditFeedManager;
@property (nonatomic, strong) NSMutableArray *redditComments;

@property (nonatomic, strong) RKObjectRequestOperation* loadingOperation;

@end

@implementation PPSubRedditCommentsViewController

#pragma mark - init

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        _redditFeedManager = [PPRedditFeedManager new];
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNavigationBar];
    [self setTreeView];

    [self loadData];
}

#pragma mark - RATreeViewDataSource

- (NSInteger)treeView:(RATreeView*)treeView numberOfChildrenOfItem:(id)item
{
    return item ? ((PPRedditComment*)item).replies.count : self.redditComments.count;
}

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    //NSInteger numberOfChildren = [treeNodeInfo.children count];
    
    PPSubRedditCommentCell *cell = [treeView dequeueReusableCellWithIdentifier:ppSubRedditCommentCellIdentifier];
    [cell dataBindWithSubRedditComment:(PPRedditComment *)item];
    
    return cell;
}

-(id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    return item ? ((PPRedditComment*)item).replies[index] : [self.redditComments objectAtIndex:index];
}

#pragma mark - RATreeViewDelegate

-(CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return ppSubRedditCommentCellHeight;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor redditPaleBlue];
    }
}

-(BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return NO;
}

#pragma mark - Handlers

-(void)closeButtonTapped:(id)sender
{
    if(self.loadingOperation)
    {
       [self.loadingOperation cancel];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)retryFailedLoadingGestureRecognizerTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self.view removeGestureRecognizer:gestureRecognizer];
    
    self.loadingMessageLabel.numberOfLines = 1;
    self.loadingMessageLabel.text = @"Loading data...";
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
   [self loadData];
}

#pragma mark - Private methods

-(void)setNavigationBar
{
    [self setTwoLineNavigationBarTitleWithText:self.feed.title];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closeButtonTapped:)];
    self.navigationItem.rightBarButtonItems = @[closeButton];
}

-(void)setTreeView
{
    self.treeview.dataSource = self;
    self.treeview.delegate = self;
    [self.treeview registerNib:[UINib nibWithNibName:@"PPSubRedditCommentCell" bundle:nil] forCellReuseIdentifier:ppSubRedditCommentCellIdentifier];
    self.treeview.rowHeight = ppSubRedditCommentCellHeight;
}

-(void)loadData
{
    self.loadingOperation = [self.redditFeedManager commentsForSubRedditWithPermalink:self.feed.permalink
                                                 successBlock: ^(NSArray* comments){
                                                     
                                                     self.loadingOperation = nil;
                                                     
                                                     self.redditComments = [NSMutableArray arrayWithArray:comments];
                                                    
                                                     self.loadingMessageLabel.hidden = YES;
                                                     self.activityIndicator.hidden = YES;
                                                     [self.activityIndicator stopAnimating];
                                                     
                                                     self.treeview.hidden = NO;
                                                     [self.treeview reloadData];
                                                     
                                                 } failureBlock:^(NSError *error) {
                                                     
                                                     self.loadingOperation = nil;
                                                     
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

@end
