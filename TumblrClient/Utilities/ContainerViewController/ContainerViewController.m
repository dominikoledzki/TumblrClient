//
//  ContainerViewController.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation ContainerViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    return self;
}


- (void)showViewController:(UIViewController *)vc animated:(BOOL)animated {
    UIViewController *from = _currentViewController;
    UIViewController *to = vc;
    
    [from willMoveToParentViewController:nil];
    [self addChildViewController:to];
    
    [from beginAppearanceTransition:NO animated:animated];
    [to beginAppearanceTransition:YES animated:animated];
    
    void(^animationBlock)(void) = ^{
        [from.view removeFromSuperview];
        to.view.frame = self.view.bounds;
        to.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:to.view];
    };
    
    void(^completionBlock)(BOOL) = ^(BOOL finished) {
        [from endAppearanceTransition];
        [to endAppearanceTransition];
        
        [to didMoveToParentViewController:self];
        [from removeFromParentViewController];
    };
    
    if (animated) {
        [UIView transitionWithView:self.view
                          duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:animationBlock
                        completion:completionBlock];
    } else {
        animationBlock();
        completionBlock(YES);
    }
}

@end
