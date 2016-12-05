//
//  BlogSelectViewController.h
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlogSelectViewControllerDelegate;
@interface BlogSelectViewController : UIViewController

@property(nonatomic, weak) id<BlogSelectViewControllerDelegate> delegate;

@end

@protocol BlogSelectViewControllerDelegate <NSObject>
@optional
- (void)blogSelectViewController:(BlogSelectViewController *)vc didSelectBlogName:(NSString *)blogName;

@end
