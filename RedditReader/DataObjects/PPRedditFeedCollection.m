//
//  PPRedditFeedColletion.m
//  RedditReader
//
//  Created by pragmapilot on 11/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedCollection.h"
#import "PPRedditFeed.h"

@implementation PPRedditFeedCollection

#pragma mark - Public methods

+(RKObjectMapping*)restKitMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                 @"after":  @"after",
                                                 @"before": @"before"
                                                 }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"children.data"
                                                                            toKeyPath:@"feeds"
                                                                          withMapping:[PPRedditFeed restKitMapping]]];

    return mapping;
}

@end
