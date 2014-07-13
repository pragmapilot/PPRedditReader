//
//  PPSubRedditCommentCell.h
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ppSubRedditCommentCellIdentifier = @"SubRedditCommentCell";
static CGFloat const ppSubRedditCommentCellHeight = 88.f;

@interface PPSubRedditCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *upvotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@end
