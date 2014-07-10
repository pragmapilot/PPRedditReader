//
//  PPRedditFeedListViewController.h
//  RedditReader
//
//  Created by pragmapilot on 07/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPRedditFeedListViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) IBOutlet UILabel *loadingMessageLabel;
@property (nonatomic, strong) IBOutlet UITableView *table;

@end
