//
//  ErrorViewController.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorViewControllerDelegate;
@interface ErrorViewController : UIViewController

@property (nonatomic, weak) id<ErrorViewControllerDelegate> delegate;

- (instancetype)initWithMessageTitle:(NSString *)messageTitle messageBody:(NSString *)messageBody buttonTitle:(NSString *)buttonTitle;

@end

@protocol ErrorViewControllerDelegate <NSObject>
@optional

- (void)errorViewControllerButtonTapped:(ErrorViewController *)vc;

@end
