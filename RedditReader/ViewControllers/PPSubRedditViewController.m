//
//  PPSubRedditViewController.m
//  RedditReader
//
//  Created by pragmapilot on 09/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPSubRedditViewController.h"
#import "PPRedditFeed.h"
#import "PPViewFactory.h"
#import "PPUtils.h"
#import "PPSubRedditCommentsViewController.h"
#import "UIViewController+TwoLineNavBarTitle.h"

@interface PPSubRedditViewController () <UIWebViewDelegate>

@end

@implementation PPSubRedditViewController

#pragma mark - ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self setTwoLineNavigationBarTitleWithText:self.feed.title];
    
    NSURL *url = [NSURL URLWithString:self.feed.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(self.webView.loading)
    {
       [self.webView stopLoading];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"subRedditToCommentsSegue"])
    {
        // Hide back button title...cool one! :-)
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:nil
                                                                                action:nil];

        PPSubRedditCommentsViewController *commentsViewController = (PPSubRedditCommentsViewController *) ((UINavigationController*)segue.destinationViewController).topViewController;
        commentsViewController.feed = self.feed;
    }
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadingMessageLabel.text = @"Loading data...";
    self.loadingMessageLabel.hidden = NO;
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    self.refreshButton.enabled = NO;
    self.stopLoadingButton.enabled = YES;
    self.commentsButton.enabled = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    self.loadingMessageLabel.hidden = YES;
    self.webView.hidden = NO;
    self.toolBar.hidden = NO;
    
    if(self.webView.canGoBack)
        self.backButton.enabled = YES;
    
    if (self.webView.canGoForward)
        self.forwardButton.enabled = YES;
    
    self.refreshButton.enabled = YES;
    
    if(! IsEmpty(self.feed.permalink))
            self.commentsButton.enabled = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;

    self.loadingMessageLabel.hidden = NO;
    self.loadingMessageLabel.text = @"Can't load content.";
    
    self.toolBar.hidden = NO;
    self.refreshButton.enabled = YES;
    self.stopLoadingButton.enabled = NO;
    self.commentsButton.enabled = NO;
}

@end
