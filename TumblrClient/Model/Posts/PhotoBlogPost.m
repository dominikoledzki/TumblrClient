//
//  PhotoBlogPost.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "PhotoBlogPost.h"

@implementation PhotoBlogPost

+ (void)load {
    if (self == [PhotoBlogPost class]) {
        [BlogPost registerClass:self forPostType:@"photo"];
    }
}

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml {
    self = [super initWithXmlElement:xml];
    if (self) {
        self.photoCaption = [[xml firstChildWithTag:@"photo-caption"] stringValue];
        NSString *photoUrl = [[xml firstChildWithXPath:@"photo-url[@max-width='500']"] stringValue];
        self.photoUrl = [[NSURL alloc] initWithString:photoUrl];
    }
    return self;
}

@end
