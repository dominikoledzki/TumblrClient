//
//  AppDelegate.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 03/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "AppDelegate.h"
#import "BlogSelectViewController.h"
#import "PostsListViewController.h"

@interface AppDelegate () <BlogSelectViewControllerDelegate>

@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    BlogSelectViewController *blogSelectVC = [[BlogSelectViewController alloc] init];
    blogSelectVC.delegate = self;
    
    _navController = [[UINavigationController alloc] initWithRootViewController:blogSelectVC];
    
    self.window.rootViewController = _navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)blogSelectViewController:(BlogSelectViewController *)vc didSelectBlogName:(NSString *)blogName {
    PostsListViewController *postsVC = [[PostsListViewController alloc] initWithBlogName:blogName];
    [self.navController pushViewController:postsVC animated:YES];
}

@end
