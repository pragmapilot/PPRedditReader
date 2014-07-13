//
//  PPURLFactory.m
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPURLFactory.h"
#import "PPUtils.h"

static NSDictionary *_urlMappings;

static NSString const *redditBaseURLKey = @"reddit_base_url";

static NSString const * jsonExtension = @".json";

@implementation PPURLFactory

#pragma mark - Public methods

+(NSString*)redditDefaultPageJSONFeedURLStringAfter:(NSString*)after
{
    NSMutableString* url = [NSMutableString stringWithFormat:@"%@/%@", [PPURLFactory urlMappings][redditBaseURLKey], jsonExtension];
    
    if(!IsEmpty(after))
    {
        [url appendFormat:@"?after=%@", after];
    }
    
    return [url copy];
}

+(NSString*)urlForSubredditCommentsJSONWithPermalink:(NSString*)permalink
{
    return [NSString stringWithFormat:@"%@%@%@", [PPURLFactory urlMappings][redditBaseURLKey],permalink, jsonExtension];
}

#pragma mark - Private methods

+(NSDictionary*) urlMappings
{
    if(! _urlMappings)
    {
        NSString *rootPath = [[NSBundle mainBundle] bundlePath];
        NSString *servicesPListPath = [rootPath stringByAppendingPathComponent:@"Sources.plist"];
        _urlMappings = [NSDictionary dictionaryWithContentsOfFile:servicesPListPath];
    }
    
    return _urlMappings;
}

@end
