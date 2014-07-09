//
//  PPRedditFeed.m
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeed.h"

@implementation PPRedditFeed

+ (RKObjectMapping*)restKitMapping;
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"author":          @"author",
                                                  @"created_utc":     @"createdUTC",
                                                  @"num_comments":    @"numComments",
                                                  @"permalink":       @"permalink",
                                                  @"score":           @"score",
                                                  @"subreddit":       @"subreddit",
                                                  @"subreddit_id":    @"subredditId",
                                                  @"thumbnail":       @"thumbnail",
                                                  @"title":           @"title",
                                                  @"ups":             @"ups",
                                                  @"url":             @"url"
                                                  }];
    
    return mapping;
}

@end
