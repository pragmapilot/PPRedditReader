//
//  PPRedditFeedCell.h
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const thumbnailImageViewWidthLayoutConstraintDefaultValue;

static NSString *ppRedditFeedCellIdentifier = @"RedditFeedCell";

@interface PPRedditFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *upvotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thumbnailImageViewWidthLayoutConstraint;

@end
