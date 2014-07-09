//
//  PPRedditFeedManagerTests.m
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PPRedditFeedManager.h"
#import "PPTestMacros.h"

@interface PPRedditFeedManagerTests : XCTestCase

@property (nonatomic, strong) PPRedditFeedManager *manager;

@end

@implementation PPRedditFeedManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    
    self.manager = [PPRedditFeedManager new];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testDefaultPageFeeds
{
    // Set the flag
    StartBlock();
    
    [self.manager defaultPageFeedsWithSuccessBlock:^(NSArray *feeds) {
    
        EndBlock();
        XCTAssertNotNil(feeds, @"%s: feed array can't be nil on success!", __PRETTY_FUNCTION__);
        
    } failureBlock:^(NSError *error) {
        EndBlock();
        XCTAssertNotNil(error, @"%s: error can't be nil on failure!", __PRETTY_FUNCTION__);
    }];
    
    WaitUntilBlockCompletes();
}

@end
