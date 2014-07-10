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

@interface PPSubRedditCommentsViewController ()

@end

@implementation PPSubRedditCommentsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTwoLineNavigationBarTitleWithText:self.feed.title];
   
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closeButtonTapped:)];
    self.navigationItem.rightBarButtonItems = @[closeButton];
}

#pragma mark - Handlers

-(void)closeButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
