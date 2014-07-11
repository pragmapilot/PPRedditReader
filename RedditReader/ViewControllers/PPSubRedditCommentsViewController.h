//
//  PPSubRedditCommentsViewController.h
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPRedditFeed;
@class RATreeView;

@interface PPSubRedditCommentsViewController : UIViewController

@property (nonatomic, strong) PPRedditFeed *feed;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingMessageLabel;
@property (weak, nonatomic) IBOutlet RATreeView *treeview;

@end
