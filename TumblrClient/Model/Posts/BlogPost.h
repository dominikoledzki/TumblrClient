//
//  BlogPost.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Ono/Ono.h>

@interface BlogPost : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *type;

+ (void)registerClass:(Class)cls forPostType:(NSString *)type;
- (instancetype)initWithXmlElement:(ONOXMLElement *)xml;

@end
