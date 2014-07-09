//
//  PPAppearanceConfigurator.m
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPAppearanceConfigurator.h"
#import "UIColor+RedditReader.h"

@implementation PPAppearanceConfigurator

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static PPAppearanceConfigurator *theInstance;
    dispatch_once(&onceToken, ^{
        theInstance = [self new];
    });
    return theInstance;
}

-(void)configureAppearance
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor redditPaleBlue]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
}

@end
