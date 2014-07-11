//
//  PPRedditComment.m
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditComment.h"

@implementation PPRedditComment

+ (RKObjectMapping*)restKitMapping;
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"author":          @"author",
                                                  @"created_utc":     @"createdUTC",
                                                  @"score":           @"score",
                                                  @"subreddit":       @"subreddit",
                                                  @"subreddit_id":    @"subredditId",
                                                  @"body":            @"body",
                                                  @"ups":             @"ups",
                                                }];

    // TODO: nested replies...
    RKDynamicMapping *dynamicMapping = [RKDynamicMapping new];
    [dynamicMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        
        RKObjectMapping *result = nil;//mapping;
        
        // If there are no replies to the comment JSON has "replies":"" --> mapped to NSString!!
        if([representation isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *replies = (NSDictionary*) representation;
            
            NSDictionary *firstDataInReplies = (NSDictionary*)replies[@"data"];
            NSArray *children = (NSArray*)firstDataInReplies[@"children"];
            
            if([children.firstObject isKindOfClass:[NSString class]])
            {
                result = nil;
            }
        }
        
        return result;
    }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"replies"
                                                                            toKeyPath:@"replies"
                                                                          withMapping:dynamicMapping]];
    return mapping;
}


@end


