//
//  PPSubRedditViewController.h
//  RedditReader
//
//  Created by pragmapilot on 09/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPRedditFeed;

@interface PPSubRedditViewController : UIViewController

@property (strong, nonatomic) PPRedditFeed *feed;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingMessageLabel;

@end