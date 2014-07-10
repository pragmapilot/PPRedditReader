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

    RKDynamicMapping *dynamicMapping = [RKDynamicMapping new];
    [dynamicMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        
#pragma message "DO SOMETHING ABOUT THIS..."
        if([representation isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *replies = (NSDictionary*)representation;
            
            NSArray *children = ((NSDictionary*)replies[@"data"])[@"children"];
            NSDictionary *lastNode = children[children.count - 1];
            
            if([lastNode[@"kind"] isEqualToString:@"more"])
                DLog(@"%@", representation);
        }
        
        return nil;
    }];
    

    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"replies"
                                                                            toKeyPath:@"replies"
                                                                          withMapping:dynamicMapping]];
    
   return mapping;
}


@end
