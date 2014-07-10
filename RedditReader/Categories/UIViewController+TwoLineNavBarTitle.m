//
//  UIViewController+TwoLineNavBarTitle.m
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "UIViewController+TwoLineNavBarTitle.h"
#import "PPViewFactory.h"

@implementation UIViewController (TwoLineNavBarTitle)

-(void)setTwoLineNavigationBarTitleWithText:(NSString*)title
{
    CGRect titleFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.navigationController.navigationBar.bounds));
    self.navigationItem.titleView = [PPViewFactory twoLineNavigationBarTitleWithFrame:titleFrame text:title];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:[PPViewFactory rightSpacerNavigationBarAligner]];
}
@end
