//
//  PPRedditFeedCell.m
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedCell.h"
#import "PPViewFactory.h"

CGFloat const thumbnailImageViewWidthLayoutConstraintDefaultValue = 88.0;

@implementation PPRedditFeedCell

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.thumbnailImageView.image = [PPViewFactory redditFeedCellPlaceholderImage];
    self.thumbnailImageViewWidthLayoutConstraint.constant = thumbnailImageViewWidthLayoutConstraintDefaultValue;
    self.titleLabel.text = nil;
    self.authorLabel.text = nil;
    self.upvotesLabel.text = nil;
    self.commentsLabel.text = nil;
}

@end
