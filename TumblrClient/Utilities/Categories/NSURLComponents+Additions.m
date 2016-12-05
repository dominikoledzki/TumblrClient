//
//  NSURLComponents+Additions.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "NSURLComponents+Additions.h"

@implementation NSURLComponents (Additions)

- (NSURL *)urlWithPath:(NSString *)path andQueryItems:(NSArray *)queryItems {
    NSURLComponents *copy = [self copy];
    copy.path = path;
    copy.queryItems = queryItems;
    return copy.URL;
}

@end
