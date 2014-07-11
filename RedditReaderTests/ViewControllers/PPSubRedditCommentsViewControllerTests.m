//
//  PPSubRedditCommentsViewControllerTests.m
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PPSubRedditCommentsViewController.h"
#import "PPSubRedditCommentCell.h"
#import "PPSubRedditCommentCell+DataBind.h"
#import <RATreeView/RATreeView.h>
#import "PPRedditComment.h"
#import "NSDate+DateTools.h"

static NSInteger const baseNumber = 42;

static NSString *author = @"pragmaPilot";
static NSString *body = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut dolor et enim molestie venenatis.";
static NSInteger const ups = baseNumber + 1;
static NSInteger const timestamp = 463103880;

@interface PPSubRedditCommentsViewControllerTests : XCTestCase

@property (nonatomic, strong) PPSubRedditCommentsViewController *vc;
@property (nonatomic, strong) PPRedditComment *comment;
@property (nonatomic, strong) PPSubRedditCommentCell *cachedCell;

@end

@implementation PPSubRedditCommentsViewControllerTests

- (void)setUp
{
    [super setUp];

    self.comment = [PPRedditComment new];
    
    self.comment.author = author;
    self.comment.body = body;
    self.comment.ups = ups;
    self.comment.createdUTC = timestamp;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [storyboard instantiateViewControllerWithIdentifier:@"SubRedditCommentsViewController"];
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [self.vc performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
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
    XCTAssertTrue([subviews containsObject:self.vc.treeview], @"View does not have a tree view subview");
    XCTAssertTrue([subviews containsObject:self.vc.activityIndicator], @"View does not have an activity indicator subview");
    XCTAssertTrue([subviews containsObject:self.vc.loadingMessageLabel], @"View does not have a loading message label subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.vc.treeview, @"TreeView not initiated");
}

#pragma mark - UITableView tests

- (void)testVCConformsToRATreeViewDataSource
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(RATreeViewDataSource) ], @"View controller does not conform to RATreeViewDataSource protocol");
}

- (void)testTreeViewHasDataSource
{
    XCTAssertNotNil(self.vc.treeview.dataSource, @"TreeView datasource cannot be nil");
}

- (void)testVCConformsToRATreeViewDelegate
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(RATreeViewDelegate) ], @"View controller does not conform to RATreeViewDelegate protocol");
}

- (void)testTreeViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.vc.treeview.delegate, @"TreeView delegate cannot be nil");
}

- (void)testTreeViewCellHeight
{
    CGFloat expectedHeight = 88.f;
    CGFloat actualHeight = self.vc.treeview.rowHeight;
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testTreeViewCellCreateCellsWithReuseIdentifier
{
    PPSubRedditCommentCell *cell = self.cachedCell;
    
    NSString *expectedReuseIdentifier = ppSubRedditCommentCellIdentifier;
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"TreeView does not create reusable cells");
}

- (void)testCellDataBinding
{
    PPSubRedditCommentCell *cell = self.cachedCell;
    
    XCTAssertNotNil(cell, @"Cell can't be nil!");
    
    [cell dataBindWithSubRedditComment:self.comment];
    
    NSDate *commentDate = [NSDate dateWithTimeIntervalSince1970:self.comment.createdUTC];
    NSString *expectedCommentDate = [commentDate timeAgoSinceNow];
    
    XCTAssertEqualObjects(cell.timestampLabel.text, expectedCommentDate, @"Got %@ for cell timestamp label text and should have gotten %@", cell.timestampLabel.text, expectedCommentDate);
    
    NSString *expectedUpvotesText = [NSString stringWithFormat:@"%d upvotes", self.comment.ups];
    
    XCTAssertEqualObjects(cell.upvotesLabel.text, expectedUpvotesText, @"Got %@ for cell author label text and should have gotten %@", cell.upvotesLabel.text, expectedUpvotesText);
    
    XCTAssertEqualObjects(cell.bodyLabel.text, self.comment.body, @"Got %@ for cell body label text and should have gotten %@", cell.bodyLabel.text, self.comment.body);
   
    XCTAssertEqualObjects(cell.authorLabel.text, self.comment.author, @"Got %@ for cell author label text and should have gotten %@", cell.authorLabel.text, self.comment.author);
  
}

#pragma mark - Helper methods

-(PPSubRedditCommentCell*)cachedCell
{
    if(! _cachedCell)
    {
        PPSubRedditCommentCell *tempCell;
        
        // treeView:cellForItem:treeNodeInfo: isn't public and performSelector:withObject:withObject: supports a max of 2 params and method has 3
        NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature:    [[self.vc class] instanceMethodSignatureForSelector:@selector(treeView:cellForItem:treeNodeInfo:)]];
        [myInvocation setTarget:self.vc];
        [myInvocation setSelector:@selector(treeView:cellForItem:treeNodeInfo:)];
        
        RATreeView *treeView = self.vc.treeview;
        PPRedditComment *comment = self.comment;
        RATreeNodeInfo *nodeInfo = [RATreeNodeInfo new];
        
        [myInvocation setArgument:&treeView atIndex:2];
        [myInvocation setArgument:&comment atIndex:3];
        [myInvocation setArgument:&nodeInfo atIndex:4];
        
        [myInvocation retainArguments];
        [myInvocation invoke];
        [myInvocation getReturnValue:&tempCell];
        
        _cachedCell = tempCell;
    }
    
    return _cachedCell;
}

@end

