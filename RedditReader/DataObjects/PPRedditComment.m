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
        
        RKObjectMapping *result = nil; //mapping; -> só mostra o primeiro nível de recursividade
        
        if([representation isKindOfClass:[NSString class]] && [representation isEqualToString:@""])
        {
            result = nil;
        }
        
        return result;
    }];
   
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"replies"
                                                                            toKeyPath:@"replies"
                                                                          withMapping:dynamicMapping]];
    
    return mapping;
}

@end


