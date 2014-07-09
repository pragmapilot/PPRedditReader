//
//  PPRedditFeedCell+DataBind.m
//  RedditReader
//
//  Created by pragmapilot on 08/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPRedditFeedCell+DataBind.h"
#import "PPRedditFeed.h"
#import <AFNetworking/AFNetworking.h>
#import "PPViewFactory.h"
#import "PPUtils.h"

@implementation PPRedditFeedCell (DataBind)

#pragma mark - Public methods

-(void)dataBindWithRedditFeed: (PPRedditFeed*)redditFeed
{
    if(! IsEmpty(redditFeed.thumbnail))
    {
        NSURL *url = [NSURL URLWithString:redditFeed.thumbnail];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.thumbnailImageView setImageWithURLRequest:request placeholderImage:[PPViewFactory redditFeedCellPlaceholderImage] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            self.thumbnailImageView.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            [self hideThumbnail];
        }];
    }
    else
    {
        [self hideThumbnail];
    }
    
    if(! IsEmpty(redditFeed.title))
    {
        self.titleLabel.text = redditFeed.title;
    }
    else
    {
        self.titleLabel.text = nil;
    }

    if(! IsEmpty(redditFeed.author))
    {
        self.authorLabel.text = redditFeed.author;
    }
    else
    {
        self.authorLabel.text = nil;
    }

    if(redditFeed.ups >= 0)
    {
        self.upvotesLabel.text = [NSString stringWithFormat:@"%d upvotes", redditFeed.ups];
    }
    
    if(redditFeed.numComments > 0)
    {
        self.commentsLabel.text = [NSString stringWithFormat:@"%d comments", redditFeed.numComments];
    }
}

#pragma mark - Private methods

- (void)hideThumbnail
{
    self.thumbnailImageView.image = nil;
    self.thumbnailImageViewWidthLayoutConstraint.constant = 0.f;
}

@end
