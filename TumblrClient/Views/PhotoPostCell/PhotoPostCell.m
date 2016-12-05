//
//  PhotoPostCell.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "PhotoPostCell.h"
#import "UIImage+Additions.h"

@interface PhotoPostCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) NSLayoutConstraint *aspectRatioConstraint;

@end

static const CGFloat defaultMargin = 20.0;


@implementation PhotoPostCell

+ (CGFloat)estimatedRowHeight {
    return 140.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.photoImageView];
        
        [[self.photoImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:defaultMargin] setActive:YES];
        [[self.photoImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-defaultMargin] setActive:YES];
        [[self.photoImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:defaultMargin] setActive:YES];
        [[self.photoImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-defaultMargin] setActive:YES];
        [[self.photoImageView.heightAnchor constraintGreaterThanOrEqualToConstant:100.0] setActive:YES];
        
        self.photoImageView.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)setupWithPost:(PhotoBlogPost *)post {
    [super setupWithPost:post];
    
    [self.aspectRatioConstraint setActive:NO];
    self.aspectRatioConstraint = nil;
    
    if (post.photo) {
        self.photoImageView.image = post.photo;
        CGFloat aspectRatio = [post.photo aspectRatio];
        self.aspectRatioConstraint = [self.photoImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor multiplier:aspectRatio];
        [self.aspectRatioConstraint setActive:YES];
    } else {
        self.photoImageView.image = nil;
    }
}

@end
