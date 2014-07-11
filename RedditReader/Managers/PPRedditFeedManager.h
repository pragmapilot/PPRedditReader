//
//  PPRedditFeedManager.h
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPRedditFeedCollection;

@interface PPRedditFeedManager : NSObject

- (void)defaultPageFeedsAfter: (NSString*)after
                 successBlock:(void(^)(PPRedditFeedCollection* feedColletion))successBlock
                 failureBlock:(void(^)(NSError* error))failureBlock;

-(void)commentsForSubRedditWithPermalink:(NSString*)permalink
                            successBlock:(void(^)(NSArray* comments))successBlock
                            failureBlock:(void(^)(NSError* error))failureBlock;

@end
