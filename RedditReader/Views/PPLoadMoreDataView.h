//
//  PPLoadMoreDataView.h
//  RedditReader
//
//  Created by pragmapilot on 11/07/14.
//  Copyright (c) 2014 PragmaPilot. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const ppLoadMoreDataViewHeight = 44.f;

@interface PPLoadMoreDataView : UIView

-(void)startAnimating;
-(void)stopAnimating;

@end
