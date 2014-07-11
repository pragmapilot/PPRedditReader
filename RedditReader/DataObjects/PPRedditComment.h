//
//  PPRedditComment.h
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "PPBaseRedditDataObject.h"

@interface PPRedditComment : PPBaseRedditDataObject

@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSArray *replies;

+ (RKObjectMapping*)restKitMapping;

@end
