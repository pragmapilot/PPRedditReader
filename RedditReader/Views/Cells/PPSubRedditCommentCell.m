//
//  PPSubRedditCommentCell.m
//  RedditReader
//
//  Created by pragmapilot on 10/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPSubRedditCommentCell.h"

@implementation PPSubRedditCommentCell

#pragma mark - UITableViewCell

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.bodyLabel.text = nil;
    self.authorLabel.text = nil;
    self.upvotesLabel.text = nil;
    self.timestampLabel.text = nil;
}

@end
