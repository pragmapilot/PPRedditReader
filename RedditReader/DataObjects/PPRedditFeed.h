//
//  PPRedditFeed.h
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "PPBaseRedditDataObject.h"

@interface PPRedditFeed : PPBaseRedditDataObject

@property (nonatomic, readwrite) NSInteger numComments;
@property (nonatomic, copy) NSString *permalink;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

+ (RKObjectMapping*)restKitMapping;

@end
