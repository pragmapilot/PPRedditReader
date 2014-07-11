//
//  PPRedditFeedColletion.h
//  RedditReader
//
//  Created by pragmapilot on 11/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface PPRedditFeedCollection : NSObject

@property (nonatomic, strong) NSMutableArray *feeds;
@property (nonatomic, copy) NSString *after;
@property (nonatomic, copy) NSString *before;

+(RKObjectMapping*)restKitMapping;

@end
