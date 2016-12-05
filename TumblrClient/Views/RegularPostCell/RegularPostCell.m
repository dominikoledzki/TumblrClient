//
//  RegularPostCell.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegularPostCell.h"
#import "RegularBlogPost.h"

@interface RegularPostCell () <UIWebViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;

@property (nonatomic, strong) NSLayoutConstraint *aspectRatioConstraint;

@end


static const CGFloat defaultMargin = 20.0;
@implementation RegularPostCell

+ (CGFloat)estimatedRowHeight {
    return 140.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        [[self.titleLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:defaultMargin] setActive:YES];
        [[self.titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-defaultMargin] setActive:YES];
        [[self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:defaultMargin] setActive:YES];
        
        self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.bodyLabel.numberOfLines = 0;
        self.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.bodyLabel];
        
        [[self.bodyLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:defaultMargin] setActive:YES];
        [[self.bodyLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-defaultMargin] setActive:YES];
        [[self.bodyLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:defaultMargin] setActive:YES];
        [[self.bodyLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-defaultMargin] setActive:YES];
    }
    return self;
}

- (void)setupWithPost:(RegularBlogPost *)post {
    [super setupWithPost:post];
    
    [self.aspectRatioConstraint setActive:NO];
    self.aspectRatioConstraint = nil;
    
    self.titleLabel.text = post.regularTitle;
    if (post.regularBody) {
        
        if (!post.attributedBody) {
            post.attributedBody = [[NSAttributedString alloc] initWithData:[post.regularBody dataUsingEncoding:NSUTF8StringEncoding]
                                                                        options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                             documentAttributes:nil error:nil];
        }
        self.bodyLabel.attributedText = post.attributedBody;
    } else {
        self.bodyLabel.attributedText = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.bounds.size.width;
    self.bodyLabel.preferredMaxLayoutWidth = self.bodyLabel.bounds.size.width;
}

@end
