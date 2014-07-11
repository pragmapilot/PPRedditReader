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
#import "PPRedditFeed.h"
#import "PPRedditComment.h"
#import "PPRedditFeedCollection.h"
#import "PPUtils.h"

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
    
    [self.manager defaultPageFeedsAfter:nil successBlock:^(PPRedditFeedCollection *feedColletion) {
        EndBlock();
        XCTAssertNotNil(feedColletion, @"%s: feed collection can't be nil on success!", __PRETTY_FUNCTION__);
        XCTAssertTrue(feedColletion.feeds, @"%s: feed collection count must be greater than zero on success!", __PRETTY_FUNCTION__);
    } failureBlock:^(NSError *error) {
        EndBlock();
        XCTAssertNotNil(error, @"%s: error can't be nil on failure!", __PRETTY_FUNCTION__);
    }];
    
    WaitUntilBlockCompletes();
}

- (void)testComments
{
   __block NSArray *feeds = nil;
    
    StartBlock();
    
    [self.manager defaultPageFeedsAfter:nil successBlock:^(PPRedditFeedCollection *feedColletion) {
        EndBlock();
        feeds = feedColletion.feeds;
    } failureBlock:^(NSError *error) {
        EndBlock();
    }];
    
    WaitUntilBlockCompletes();
   
    __block PPRedditFeed *feedWithComments;
    
    [feeds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PPRedditFeed *feed = (PPRedditFeed*) obj;

        if(! IsEmpty(feed.permalink))
        {
            feedWithComments = feed;
            *stop = YES;
        }
    }];
    
    RestartBlock();
    
    [self.manager commentsForSubRedditWithPermalink: feedWithComments.permalink
                                       successBlock:^(NSArray *comments) {
                                           EndBlock();
                                           XCTAssertNotNil(comments, @"%s: comments array can't be nil on success!", __PRETTY_FUNCTION__);
                                           XCTAssertTrue(comments.count > 0, @"%s: comments array can't be empty on success!", __PRETTY_FUNCTION__);
                                       } failureBlock:^(NSError *error) {
                                           EndBlock();
                                           XCTAssertNotNil(error, @"%s: error can't be nil on failure!", __PRETTY_FUNCTION__);
    }];
    
    WaitUntilBlockCompletes();
    
    RestartBlock();
    
    [self.manager commentsForSubRedditWithPermalink: @"thi://s.is/a/bad/url/to/test?failure&block"
                                       successBlock:^(NSArray *comments) {
                                           EndBlock();
                                           XCTAssertNotNil(comments, @"%s: comments array can't be nil on success!", __PRETTY_FUNCTION__);
                                           XCTAssertTrue(comments.count > 0, @"%s: comments array can't be empty on success!", __PRETTY_FUNCTION__);
                                       } failureBlock:^(NSError *error) {
                                           EndBlock();
                                           XCTAssertNotNil(error, @"%s: error can't be nil on failure!", __PRETTY_FUNCTION__);
                                       }];
    
    WaitUntilBlockCompletes();
}


@end
