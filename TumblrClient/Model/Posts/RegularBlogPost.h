//
//  RegularBlogPost.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "BlogPost.h"

@interface RegularBlogPost : BlogPost

@property (nonatomic, copy) NSString *regularTitle;
@property (nonatomic, copy) NSString *regularBody;

@property (nonatomic, copy) NSAttributedString *attributedBody;

@end
