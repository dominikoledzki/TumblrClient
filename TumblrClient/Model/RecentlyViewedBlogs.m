//
//  RecentlyViewedBlogs.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "RecentlyViewedBlogs.h"

static NSString * const RecentlyViewedBlogsKey = @"RecentlyViewedBlogs";
static const NSUInteger RecentlyViewedBlogsCount = 10;

@implementation RecentlyViewedBlogs

- (NSArray *)getBlogNames {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:RecentlyViewedBlogsKey] ?: @[];
}

- (void)addBlog:(NSString *)blogName {
    NSMutableArray *names = [[self getBlogNames] mutableCopy];
    if (names.count > 0 && [names[0] isEqualToString:blogName])
        return;
    
    [names insertObject:blogName atIndex:0];
    while (names.count > RecentlyViewedBlogsCount) {
        [names removeLastObject];
    }
    [[NSUserDefaults standardUserDefaults] setObject:names forKey:RecentlyViewedBlogsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
