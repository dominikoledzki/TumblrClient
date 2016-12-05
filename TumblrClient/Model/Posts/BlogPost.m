//
//  BlogPost.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "BlogPost.h"

static NSMutableDictionary *blogPostClasses;

@interface BlogPost ()

@end

@implementation BlogPost

+ (void)registerClass:(Class)cls forPostType:(NSString *)type {
    assert([cls isSubclassOfClass:[BlogPost class]]);
    
    if (!blogPostClasses) {
        blogPostClasses = [NSMutableDictionary new];
    }
    
    blogPostClasses[type] = cls;
}

- (instancetype)initSelfWithXmlElement:(ONOXMLElement *)xml {
    self = [super init];
    if (self) {
        self.type = xml.attributes[@"type"];
        self.identifier = xml.attributes[@"id"];
    }
    return self;
}

- (instancetype)initSubclassWithXmlElement:(ONOXMLElement *)xml {
    NSString *type = xml.attributes[@"type"];
    Class postClass = blogPostClasses[type];
    if (postClass == Nil)
        return nil;
    else
        return  [[postClass alloc] initWithXmlElement:xml];
}

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml {
    if ([self class] == [BlogPost class]) {
        // Factory method
        return [self initSubclassWithXmlElement:xml];
        
    } else {
        // Typical init
        return [self initSelfWithXmlElement:xml];
    }
}

@end
