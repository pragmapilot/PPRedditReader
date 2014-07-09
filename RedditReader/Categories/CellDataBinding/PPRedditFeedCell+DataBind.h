//
//  PPRedditFeedCell+DataBind.h
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedCell.h"

@class PPRedditFeed;

@interface PPRedditFeedCell (DataBind)

-(void)dataBindWithRedditFeed: (PPRedditFeed*)redditFeed;

@end
