//
//  Services.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tumblelog.h"
#import "BlogPostsServiceResponse.h"

@interface Services : NSObject

- (instancetype)initWithBlogName:(NSString *)blogName;
- (void)getBlogPostsStartingWith:(NSUInteger)start pageSize:(NSUInteger)pageSize completionHandler:(void (^)(BlogPostsServiceResponse *response, NSError *error))completionHandler;

- (void)downloadImageWithUrl:(NSURL *)url completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;

@end
