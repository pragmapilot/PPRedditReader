//
//  PPBaseRedditDataObject.h
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBaseRedditDataObject : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, readwrite) NSInteger createdUTC;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, copy) NSString *subreddit;
@property (nonatomic, copy) NSString *subredditId;
@property (nonatomic, readwrite) NSInteger ups;

@end
