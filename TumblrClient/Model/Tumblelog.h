//
//  Tumblelog.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Ono/Ono.h>
#import <Foundation/Foundation.h>

@interface Tumblelog : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithXmlElement:(ONOXMLElement *)xml;

@end
