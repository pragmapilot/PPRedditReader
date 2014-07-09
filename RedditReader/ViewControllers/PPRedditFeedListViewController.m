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

@interface PPRedditFeedListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) PPRedditFeedManager *redditFeedManager;
@property (nonatomic, strong) NSMutableArray *redditPosts;

@end

@implementation PPRedditFeedListViewController

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

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.redditFeedManager defaultPageFeedsWithSuccessBlock:^(NSArray *feeds) {
        
        self.redditPosts = [NSMutableArray arrayWithArray:feeds];
        
        self.loadingDataLabel.hidden = YES;
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.table.hidden = NO;
        [self.table reloadData];
        
    } failureBlock:^(NSError *error) {
        
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.loadingDataLabel.text = @"Could not load data...";
        
        // TODO: Retry button!!!
        
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redditPosts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPRedditFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:ppRedditFeedCellIdentifier];
    [cell dataBindWithRedditFeed:self.redditPosts[indexPath.row ]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
