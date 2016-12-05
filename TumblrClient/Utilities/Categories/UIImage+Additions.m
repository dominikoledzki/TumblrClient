//
//  UIImage+Additions.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 05/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (CGFloat)aspectRatio {
    return self.size.width / self.size.height;
}

@end
