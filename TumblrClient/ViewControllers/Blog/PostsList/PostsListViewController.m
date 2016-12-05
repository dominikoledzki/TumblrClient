//
//  PostsListViewController.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "PostsListViewController.h"
#import "LoadingView.h"
#import "Services.h"
#import "RegularPostCell.h"
#import "PhotoPostCell.h"

@interface PostsListViewController ()

@property (nonatomic, copy) NSString *blogName;
@property (nonatomic, strong) LoadingView *loadingView;
@property (nonatomic, strong) Services *services;

@property (nonatomic, strong) BlogPostsServiceResponse *lastResponse;
@property (nonatomic, strong) NSMutableArray *posts;

@end

static const NSUInteger pageSize = 20;

@implementation PostsListViewController

- (instancetype)initWithBlogName:(NSString *)blogName {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.title = blogName;
        self.services = [[Services alloc] initWithBlogName:blogName];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.tableView registerClass:[RegularPostCell class] forCellReuseIdentifier:[RegularPostCell cellIdentifier]];
    [self.tableView registerClass:[PhotoPostCell class] forCellReuseIdentifier:[PhotoPostCell cellIdentifier]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    
    self.loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.loadingView];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController setHidesBarsOnSwipe:YES];
}

- (void)reloadData {
    self.lastResponse = nil;
    self.posts = nil;
    [self loadData];
}

- (void)loadData {
    [self.loadingView startAnimating];
    
    NSUInteger start = self.lastResponse ? self.lastResponse.start + pageSize : 0;
    
    __weak typeof(self) wself = self;
    [self.services getBlogPostsStartingWith:start pageSize:pageSize completionHandler:^(BlogPostsServiceResponse *response, NSError *error) {
        if (!wself)
            return;
        
        [wself.loadingView stopAnimating];
        
        if (!wself.posts)
            wself.posts = [NSMutableArray new];
        
        [wself.posts addObjectsFromArray:response.posts];
        [wself downloadPhotos:response.posts];
        [wself.tableView reloadData];
    }];
}

- (void)downloadPhotos:(NSArray *)newPosts {
    for (BlogPost *post in newPosts) {
        if ([post isKindOfClass:[PhotoBlogPost class]]) {
            PhotoBlogPost *photoPost = (PhotoBlogPost *)post;
            if (photoPost.photoUrl) {
                __weak typeof(self) wself = self;
                [self.services downloadImageWithUrl:photoPost.photoUrl completionHandler:^(UIImage *image, NSError *error) {
                    if (image) {
                        photoPost.photo = image;
                        [wself reloadPost:photoPost];
                    }
                }];
            }
        }
    }
}

- (void)reloadPost:(BlogPost *)post {
    NSUInteger index = [self.posts indexOfObject:post];
    if (index != NSNotFound) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts ? self.posts.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogPost *post = self.posts[indexPath.row];
    BlogPostCell *cell = nil;
    Class cellClass = [self cellClassForPost:post];
    cell = [tableView dequeueReusableCellWithIdentifier:[cellClass cellIdentifier]];
    
    [cell setupWithPost:post];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogPost *post = self.posts[indexPath.row];
    Class cellClass = [self cellClassForPost:post];
    return [cellClass estimatedRowHeight];
}

- (Class)cellClassForPost:(BlogPost *)post {
    Class postClass = [post class];
    
    if (postClass == [PhotoBlogPost class]) {
        return [PhotoPostCell class];
    } else if (postClass == [RegularBlogPost class]) {
        return [RegularPostCell class];
    } else {
        return Nil;
    }
}

@end
