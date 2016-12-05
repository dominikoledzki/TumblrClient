//
//  PhotoBlogPost.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogPost.h"

@interface PhotoBlogPost : BlogPost

@property (nonatomic, copy) NSString *photoCaption;
@property (nonatomic, copy) NSURL *photoUrl;
@property (nonatomic, strong) UIImage *photo;

@end
