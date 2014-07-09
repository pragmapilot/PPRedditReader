//
//  PPSubRedditViewControllerTests.m
//  RedditReader
//
//  Created by pragmapilot on 09/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PPSubRedditViewController.h"

@interface PPSubRedditViewControllerTests : XCTestCase

@property (nonatomic, strong) PPSubRedditViewController *vc;

@end

@implementation PPSubRedditViewControllerTests

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"SubRedditViewController"];
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)tearDown
{
    self.vc = nil;
    [super tearDown];
}

#pragma mark - View loading tests

-(void)testViewLoad
{
    XCTAssertNotNil(self.vc.view, @"View not initiated properly");
}

- (void)testVCViewHasSubviews
{
    NSArray *subviews = self.vc.view.subviews;
    XCTAssertTrue([subviews containsObject:self.vc.webView], @"View does not have a webview subview");
    XCTAssertTrue([subviews containsObject:self.vc.activityIndicator], @"View does not have an activity indicator subview");
    XCTAssertTrue([subviews containsObject:self.vc.loadingMessageLabel], @"View does not have a loading message label subview");
    XCTAssertTrue([subviews containsObject:self.vc.toolBar], @"View does not have a toolbar subview");
}

-(void)testViewsLoaded
{
    XCTAssertNotNil(self.vc.webView, @"Webview not initiated");
    XCTAssertNotNil(self.vc.activityIndicator, @"Activity indicator not initiated");
    XCTAssertNotNil(self.vc.loadingMessageLabel, @"Loading message label not initiated");
    XCTAssertNotNil(self.vc.toolBar, @"Tool bar not initiated");
    
    XCTAssertNotNil(self.vc.backButton, @"Back button not initiated");
    XCTAssertNotNil(self.vc.forwardButton, @"Forward button not initiated");
    XCTAssertNotNil(self.vc.refreshButton, @"Refresh button not initiated");
    XCTAssertNotNil(self.vc.stopLoadingButton, @"Stop loading button not initiated");
}

#pragma mark - UIWebView tests

- (void)testVCConformsToUIWebViewDelegate
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UIWebViewDelegate) ], @"VC does not conform to UIWebViewDelegate datasource protocol");
}

- (void)testWebViewHasDelegate
{
    XCTAssertNotNil(self.vc.webView.delegate, @"Webview delegate cannot be nil");
}

@end
