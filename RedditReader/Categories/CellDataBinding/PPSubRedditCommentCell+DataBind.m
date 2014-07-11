//
//  PPSubRedditCommentCell+DataBind.m
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPSubRedditCommentCell+DataBind.h"
#import "PPRedditComment.h"
#import "NSDate+DateTools.h"

@implementation PPSubRedditCommentCell (DataBind)

- (void)dataBindWithSubRedditComment:(PPRedditComment*)comment
{
    self.authorLabel.text = comment.author;
    
    NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:comment.createdUTC];
    self.timestampLabel.text = [createdDate timeAgoSinceNow];
    
    self.upvotesLabel.text = [NSString stringWithFormat:@"%d upvotes", comment.ups];
    self.bodyLabel.text = comment.body;
}

@end
