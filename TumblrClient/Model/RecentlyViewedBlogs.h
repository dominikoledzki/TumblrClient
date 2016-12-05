//
//  RecentlyViewedBlogs.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentlyViewedBlogs : NSObject

- (NSArray *)getBlogNames;
- (void)addBlog:(NSString *)blogName;

@end
