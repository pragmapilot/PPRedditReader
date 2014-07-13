//
//  PPViewFactory.m
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPViewFactory.h"

@implementation PPViewFactory

+ (UIImage*)redditFeedCellPlaceholderImage
{
    return [UIImage imageNamed:@"LoadingImage.png"];
}

+(UILabel*)twoLineNavigationBarTitleWithFrame: (CGRect)frame text:(NSString*)text;
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont boldSystemFontOfSize: 15.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.minimumScaleFactor = .7;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.text = text;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return titleLabel;
}

+(UIBarButtonItem*)rightSpacerNavigationBarAligner
{
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
    return space;
}

@end
