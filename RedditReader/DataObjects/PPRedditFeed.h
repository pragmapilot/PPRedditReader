//
//  PPRedditFeed.h
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface PPRedditFeed : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, readwrite) NSInteger createdUTC;
@property (nonatomic, readwrite) NSInteger numComments;
@property (nonatomic, copy) NSString *permalink;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, copy) NSString *subreddit;
@property (nonatomic, copy) NSString *subredditId;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readwrite) NSInteger ups;
@property (nonatomic, copy) NSString *url;

+ (RKObjectMapping*)restKitMapping;

@end
