//
//  PPLoadMoreDataView.m
//  RedditReader
//
//  Created by pragmapilot on 11/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import "PPLoadMoreDataView.h"
#import "MONActivityIndicatorView.h"

@interface PPLoadMoreDataView ()

@property (weak, nonatomic) IBOutlet MONActivityIndicatorView *activityDots;
@property (weak, nonatomic) IBOutlet UILabel *loadMoreDataLabel;

@end

@implementation PPLoadMoreDataView

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self viewFromNib];
        [self setUp];
    }
    return self;
}

#pragma mark - Public methods

-(void)startAnimating
{
    [self.activityDots startAnimating];
}

-(void)stopAnimating;
{
    [self.activityDots stopAnimating];
}

#pragma mark - Private methods

-(PPLoadMoreDataView*)viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:@"PPLoadMoreDataView" owner:self options:nil].firstObject;
}

-(void)setUp
{
    self.activityDots.radius = 3;
    self.activityDots.internalSpacing = 6;
    self.activityDots.duration = 0.8;
    self.activityDots.delay = 0.4;
    [self.activityDots startAnimating];
}

@end
