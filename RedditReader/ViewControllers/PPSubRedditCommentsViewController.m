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

@interface PPSubRedditCommentsViewController () <RATreeViewDataSource, RATreeViewDelegate>

@property (nonatomic, strong, readonly) PPRedditFeedManager *redditFeedManager;
@property (nonatomic, strong) NSMutableArray *redditComments;

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
    
    self.treeview.dataSource = self;
    self.treeview.delegate = self;
    [self.treeview registerNib:[UINib nibWithNibName:@"PPSubRedditCommentCell" bundle:nil] forCellReuseIdentifier:ppSubRedditCommentCellIdentifier];
    
    [self.redditFeedManager commentsForSubRedditWithPermalink:self.feed.permalink
                                                 successBlock: ^(NSArray* comments){
        
        self.redditComments = [NSMutableArray arrayWithArray:comments];
        
        self.loadingMessageLabel.hidden = YES;
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.treeview.hidden = NO;
        [self.treeview reloadData];
        
    } failureBlock:^(NSError *error) {
        
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.loadingMessageLabel.text = @"Could not load data...";
        
#pragma message "TODO: Retry button!!!"
        
    }];

}

#pragma mark - RATreeViewDataSource

- (NSInteger)treeView:(RATreeView*)treeView numberOfChildrenOfItem:(id)item
{
    return item ? ((PPRedditComment*)item).replies.count : self.redditComments.count;
}

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    NSInteger numberOfChildren = [treeNodeInfo.children count];
    
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

#pragma mark - Handlers

-(void)closeButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private methods

-(void)setNavigationBar
{
    [self setTwoLineNavigationBarTitleWithText:self.feed.title];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closeButtonTapped:)];
    self.navigationItem.rightBarButtonItems = @[closeButton];
}

@end
