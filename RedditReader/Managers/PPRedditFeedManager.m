//
//  PPRedditFeedManager.m
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedManager.h"
#import "PPRedditFeedCollection.h"
#import "PPRedditComment.h"
#import "PPURLFactory.h"

@implementation PPRedditFeedManager

- (RKObjectRequestOperation*)defaultPageFeedsAfter: (NSString*)after
                 successBlock:(void(^)(PPRedditFeedCollection* feedColletion))successBlock
                 failureBlock:(void(^)(NSError* error))failureBlock
{
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[PPRedditFeedCollection restKitMapping]
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"data"
                                                                                       statusCodes:nil];
    
    void (^internalSuccessBlock)(NSArray* feeds) = ^void(NSArray* feeds)
    {
        if(feeds && [feeds.firstObject isKindOfClass:[PPRedditFeedCollection class]] && successBlock)
        {
            successBlock(feeds.firstObject);
        }
    };

    return [self executeRequestOperationWithURL:[PPURLFactory redditDefaultPageJSONFeedURLStringAfter:after]
                      responseDescriptors:@[responseDescriptor]
                            successBlock:internalSuccessBlock
                            failureBlock:failureBlock];
}

-(RKObjectRequestOperation*)commentsForSubRedditWithPermalink:(NSString*)permalink
                            successBlock:(void(^)(NSArray* comments))successBlock
                            failureBlock:(void(^)(NSError* error))failureBlock
{
    RKResponseDescriptor *commentResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[PPRedditComment restKitMapping]
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"data"
                                                                                       statusCodes:nil];
   
   return [self executeRequestOperationWithURL:[PPURLFactory urlForSubredditCommentsJSONWithPermalink:permalink]
                      responseDescriptors:@[commentResponseDescriptor]
                            successBlock:successBlock
                            failureBlock:failureBlock
     willMapDeserializedResponseBlock:^id(id deserializedResponseBody) {
         
         id result = deserializedResponseBody;
         
         if([deserializedResponseBody isKindOfClass:[NSArray class]])
         {
             // We want to ignore response's first item: it's subreddit info...
             NSDictionary *secondNode = deserializedResponseBody[1];
             NSDictionary *secondNodeData = secondNode[@"data"];
             result = secondNodeData[@"children"];
         }
         
         return [result copy];
     }];
}

#pragma mark - Private methods

- (RKObjectRequestOperation*)executeRequestOperationWithURL:(NSString*)urlString
                    responseDescriptors:(NSArray*)responseDescriptors
                          successBlock:(void(^)(NSArray* items))successBlock
                          failureBlock:(void(^)(NSError* error))failureBlock
{
   return [self executeRequestOperationWithURL:urlString
                      responseDescriptors:responseDescriptors
                            successBlock:successBlock
                            failureBlock:failureBlock
        willMapDeserializedResponseBlock:nil];
}

- (RKObjectRequestOperation*)executeRequestOperationWithURL:(NSString*)urlString
                    responseDescriptors:(NSArray*)responseDescriptors
                          successBlock:(void(^)(NSArray* items))successBlock
                          failureBlock:(void(^)(NSError* error))failureBlock
      willMapDeserializedResponseBlock:(id(^)(id deserializedResponseBody))willMapDeserializedResponseBlock
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:responseDescriptors];
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
    
    return operation;
}

@end
