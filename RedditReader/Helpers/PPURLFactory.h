//
//  PPURLFactory.h
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPURLFactory : NSObject

+(NSString*)redditDefaultPageJSONFeedURLString;
+(NSString*)urlForSubredditCommentsJSONWithPermalink:(NSString*)permalink;

@end
