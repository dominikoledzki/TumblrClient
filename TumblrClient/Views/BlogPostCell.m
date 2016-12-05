//
//  BlogPostCell.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "BlogPostCell.h"

@implementation BlogPostCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)estimatedRowHeight {
    return 0.0;
}

- (void)setupWithPost:(BlogPost *)post {
    
}

@end
