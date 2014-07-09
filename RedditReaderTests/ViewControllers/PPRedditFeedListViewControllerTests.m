//
//  PPRedditFeedListViewControllerTests.m
//  RedditReader
//
//  Created by pragmapilot on 09/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PPRedditFeedListViewController.h"
#import "PPRedditFeed.h"
#import "PPRedditFeedCell.h"
#import "PPRedditFeedCell+DataBind.h"

static NSInteger const baseInteger = 42;

static NSString * const thumbnail = @"http://upload.wikimedia.org/wikipedia/commons/5/53/Wikipedia-logo-en-big.png";
static NSString * const title = @"Testing a cell";
static NSString * const author = @"pragmapilot";
static NSInteger const ups = baseInteger + 1;
static NSInteger const numComments = baseInteger + 2;

@interface PPRedditFeedListViewControllerTests : XCTestCase

@property (nonatomic, strong) PPRedditFeedListViewController *vc;
@property (nonatomic, strong) PPRedditFeed *feed;

@end

@implementation PPRedditFeedListViewControllerTests

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"RedditFeedListViewController"];
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
    self.feed = [PPRedditFeed new];
    self.feed.thumbnail = thumbnail;
    self.feed.title = title;
    self.feed.author = author;
    self.feed.ups = ups;
    self.feed.numComments = numComments;
}

- (void)tearDown
{
    self.feed = nil;
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
    XCTAssertTrue([subviews containsObject:self.vc.table], @"View does not have a table subview");
    XCTAssertTrue([subviews containsObject:self.vc.activityIndicator], @"View does not have an activity indicator subview");
    XCTAssertTrue([subviews containsObject:self.vc.loadingDataLabel], @"View does not have a loading data label subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.vc.table, @"TableView not initiated");
}

#pragma mark - UITableView tests

- (void)testVCConformsToUITableViewDataSource
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testTableViewHasDataSource
{
    XCTAssertNotNil(self.vc.table.dataSource, @"Table datasource cannot be nil");
}

- (void)testVCConformsToUITableViewDelegate
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.vc.table.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewCellHeight
{
    CGFloat expectedHeight = 104.0;
    CGFloat actualHeight = self.vc.table.rowHeight;
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    PPRedditFeedCell *cell = [self cellForIndexPath:indexPath];
   
    NSString *expectedReuseIdentifier = @"RedditFeedCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}

- (void)testCellDataBinding
{
    PPRedditFeedCell *cell = [self cellForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssertNotNil(cell, @"Cell can't be nil!");
    
    [cell dataBindWithRedditFeed:self.feed];
    
    // TODO: test image loading. Must investigate further. Got this, but...meh...
    // http://adoptioncurve.net/archives/2013/02/unit-testing-uiimageviews/
    
    XCTAssertEqualObjects(cell.titleLabel.text, self.feed.title, @"Got %@ for cell title label text and should have gotten %@", cell.titleLabel.text, self.feed.title);
    
    XCTAssertEqualObjects(cell.authorLabel.text, self.feed.author, @"Got %@ for cell author label text and should have gotten %@", cell.authorLabel.text, self.feed.author);
    
    NSString *expectedUpsText = [NSString stringWithFormat:@"%d upvotes", self.feed.ups];
    XCTAssertEqualObjects(cell.upvotesLabel.text, expectedUpsText, @"Got %@ for cell upvotes label text and should have gotten %@", cell.upvotesLabel.text, expectedUpsText);
    
    NSString *expectedCommentsText = [NSString stringWithFormat:@"%d comments", self.feed.numComments];
    
    XCTAssertEqualObjects(cell.commentsLabel.text, expectedCommentsText, @"Got %@ for cell comments label text and should have gotten %@", cell.commentsLabel.text, expectedCommentsText);
}

#pragma mark - Helper methods

-(PPRedditFeedCell*)cellForIndexPath: (NSIndexPath*)indexPath
{
    // tableView:cellForRowAtIndexPath is not public, so it has to be invoked with preformSelector, on main thread
   /* __block PPRedditFeedCell *cell = nil;
    
    NSOperationQueue* targetQueue = [NSOperationQueue mainQueue];
    
    [targetQueue addOperationWithBlock:^{
        cell = [self.vc performSelector:@selector(tableView:cellForRowAtIndexPath:) withObject:self.vc.table withObject:indexPath];
    }];
    
    [targetQueue waitUntilAllOperationsAreFinished];*/
    
    PPRedditFeedCell *cell = nil;
    
    cell = [self.vc performSelector:@selector(tableView:cellForRowAtIndexPath:) withObject:self.vc.table withObject:indexPath];
    
    return cell;
}

@end
