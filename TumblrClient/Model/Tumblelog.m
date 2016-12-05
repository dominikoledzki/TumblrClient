//
//  Tumblelog.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "Tumblelog.h"

@implementation Tumblelog

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml {
    self = [super init];
    if (self) {
        self.name = xml.attributes[@"name"];
        self.title = xml.attributes[@"title"];
    }
    return self;
}

@end
