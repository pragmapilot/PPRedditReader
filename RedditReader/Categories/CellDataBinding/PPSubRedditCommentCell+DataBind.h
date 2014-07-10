//
//  PPSubRedditCommentCell+DataBind.h
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPSubRedditCommentCell.h"

@class PPRedditComment;

@interface PPSubRedditCommentCell (DataBind)

- (void)dataBindWithSubRedditComment:(PPRedditComment*)comment;

@end
