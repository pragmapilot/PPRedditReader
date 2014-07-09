//
//  PPSubRedditViewController.m
//  RedditReader
//
//  Created by pragmapilot on 09/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPSubRedditViewController.h"
#import "PPRedditFeed.h"

@interface PPSubRedditViewController () <UIWebViewDelegate>

@end

@implementation PPSubRedditViewController

#pragma mark - ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadingMessageLabel.hidden = NO;
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    self.loadingMessageLabel.hidden = YES;
    self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    // TODO retry button
    self.loadingMessageLabel.text = @"Can't load content.";
}

@end
