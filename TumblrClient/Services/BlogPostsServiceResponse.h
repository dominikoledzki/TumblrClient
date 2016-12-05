//
//  BlogPostsServiceResponse.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tumblelog.h"
#import "BlogPost.h"

@interface BlogPostsServiceResponse : NSObject

@property (nonatomic, strong) Tumblelog *tumblelog;
@property (nonatomic, assign) NSUInteger start;
@property (nonatomic, assign) NSUInteger total;
@property (nonatomic, copy) NSArray *posts;

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml;

@end
