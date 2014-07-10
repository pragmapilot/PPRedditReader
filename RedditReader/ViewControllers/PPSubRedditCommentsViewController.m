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
    
    [self.redditFeedManager commentsForSubRedditWithPermalink:self.feed.permalink
                                                 successBlock: ^(NSArray* comments){
        
        self.redditComments = [NSMutableArray arrayWithArray:comments];
        
        self.loadingMessageLabel.hidden = YES;
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
       // self.treeview.hidden = NO;
       // [self.treeview reloadData];
        
    } failureBlock:^(NSError *error) {
        
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.loadingMessageLabel.text = @"Could not load data...";
        
        // TODO: Retry button!!!
        
    }];

}

#pragma mark - RATreeViewDataSource

#pragma mark - RATreeViewDelegate

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
