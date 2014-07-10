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
#import "PPRedditComment.h"
#import "PPURLFactory.h"

@implementation PPRedditFeedManager

- (void)defaultPageFeedsWithSuccessBlock:(void(^)(NSArray* feeds))successBlock
                            failureBlock:(void(^)(NSError* error))failureBlock
{
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[PPRedditFeed restKitMapping]
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"data.children.data"
                                                                                       statusCodes:nil];
    
    [self executeRequestOperationWithURL:[PPURLFactory redditDefaultPageJSONFeedURLString]
                      responseDescriptor:responseDescriptor
                            successBlock:successBlock
                            failureBlock:failureBlock];
}

-(void)commentsForSubRedditWithPermalink:(NSString*)permalink
                            successBlock:(void(^)(NSArray* comments))successBlock
                            failureBlock:(void(^)(NSError* error))failureBlock
{
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[PPRedditComment restKitMapping]
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"data.children"
                                                                                       statusCodes:nil];

    [self executeRequestOperationWithURL:[PPURLFactory urlForSubredditCommentsJSONWithPermalink:permalink]
                      responseDescriptor:responseDescriptor
                            successBlock:successBlock
                            failureBlock:failureBlock
     willMapDeserializedResponseBlock:^id(id deserializedResponseBody) {
         
         id result = deserializedResponseBody;
         
         // We want to ignore response's first item: it's subreddit info...
         if([deserializedResponseBody isKindOfClass:[NSArray class]])
         {
             NSMutableArray *deserializedJSON = [NSMutableArray arrayWithArray:deserializedResponseBody];
             [deserializedJSON removeObjectAtIndex:0];
             
             result = deserializedJSON;
         }
         
         return result;
     }];
}

#pragma mark - Private methods

- (void)executeRequestOperationWithURL:(NSString*)urlString
                    responseDescriptor:(RKResponseDescriptor*)responseDescriptor
                          successBlock:(void(^)(NSArray* items))successBlock
                          failureBlock:(void(^)(NSError* error))failureBlock
{
    [self executeRequestOperationWithURL:urlString
                      responseDescriptor:responseDescriptor
                            successBlock:successBlock
                            failureBlock:failureBlock
        willMapDeserializedResponseBlock:nil];
}

- (void)executeRequestOperationWithURL:(NSString*)urlString
                    responseDescriptor:(RKResponseDescriptor*)responseDescriptor
                          successBlock:(void(^)(NSArray* items))successBlock
                          failureBlock:(void(^)(NSError* error))failureBlock
      willMapDeserializedResponseBlock:(id(^)(id deserializedResponseBody))willMapDeserializedResponseBlock
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        if(successBlock)
            successBlock([result array]);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if(failureBlock)
            failureBlock(error);
        
    }];
    
    if(willMapDeserializedResponseBlock)
        [operation setWillMapDeserializedResponseBlock:willMapDeserializedResponseBlock];
    
    [operation start];
}

@end
