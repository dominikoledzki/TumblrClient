//
//  LoadingView.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation LoadingView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.color = [UIColor darkGrayColor];
        [self addSubview:_activityIndicator];
        self.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.activityIndicator.frame = self.bounds;
}

- (void)startAnimating {
    self.hidden = NO;
    [self.activityIndicator startAnimating];
}
- (void)stopAnimating {
    [self.activityIndicator stopAnimating];
    self.hidden = YES;
}

@end
