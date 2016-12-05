//
//  BlogPostCell.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogPost.h"

@interface BlogPostCell : UITableViewCell

+ (NSString *)cellIdentifier;
+ (CGFloat)estimatedRowHeight;
- (void)setupWithPost:(BlogPost *)post;

@end
