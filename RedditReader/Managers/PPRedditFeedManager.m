//
//  PPRedditFeedManager.m
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedManager.h"
#import <RestKit/RestKit.h>
#import "PPRedditFeed.h"
#import "PPURLFactory.h"

@implementation PPRedditFeedManager

- (void)defaultPageFeedsWithSuccessBlock:(void(^)(NSArray* feeds))successBlock failureBlock:(void(^)(NSError* error))failureBlock
{
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[PPRedditFeed restKitMapping]
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"data.children.data"
                                                                                       statusCodes:nil];
    NSURL *url = [NSURL URLWithString:[PPURLFactory redditDefaultPageJSONFeedURLString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {

        if(successBlock)
            successBlock([result array]);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if(failureBlock)
            failureBlock(error);
    
    }];
    
    [operation start];
}

@end
