//
//  BlogPostsServiceResponse.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Ono/Ono.h>
#import "BlogPostsServiceResponse.h"

@implementation BlogPostsServiceResponse

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml {
    self = [super init];
    if (self) {
        
        ONOXMLElement *tumblelog = [xml firstChildWithXPath:@"/tumblr/tumblelog"];
        self.tumblelog = [[Tumblelog alloc] initWithXmlElement:tumblelog];
        
        ONOXMLElement *xmlPosts = [xml firstChildWithXPath:@"/tumblr/posts"];
        self.start = [xmlPosts.attributes[@"start"] intValue];
        self.total = [xmlPosts.attributes[@"total"] intValue];
        
        NSMutableArray *posts = [NSMutableArray new];
        for (ONOXMLElement *xmlPost in [xmlPosts childrenWithTag:@"post"]) {
            BlogPost *post = [[BlogPost alloc] initWithXmlElement:xmlPost];
            if (post)
                [posts addObject:post];
        }
        self.posts = posts;
    }
    return self;
}

@end
