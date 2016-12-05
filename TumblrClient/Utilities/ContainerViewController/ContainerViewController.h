//
//  ContainerViewController.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *currentViewController;

- (instancetype)init;
- (void)showViewController:(UIViewController *)vc animated:(BOOL)animated;

@end
