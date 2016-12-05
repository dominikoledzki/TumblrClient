//
//  RegularBlogPost.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "RegularBlogPost.h"

@implementation RegularBlogPost

+ (void)load {
    if (self == [RegularBlogPost class]) {
        [BlogPost registerClass:self forPostType:@"regular"];
    }
}

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml {
    self = [super initWithXmlElement:xml];
    if (self) {
        
        self.regularBody = [[xml firstChildWithTag:@"regular-body"] stringValue];
        self.regularTitle = [[xml firstChildWithTag:@"regular-title"] stringValue];
        
    }
    return self;
}


@end
