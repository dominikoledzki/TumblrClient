//
//  BlogSelectViewController.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "BlogSelectViewController.h"
#import "RecentlyViewedBlogs.h"

@interface BlogSelectViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *blogNameLabel;
@property (nonatomic, strong) UITextField *blogNameTextField;
@property (nonatomic, strong) UIButton *goButton;

@property (nonatomic, strong) UILabel *recentlyViewedLabel;
@property (nonatomic, strong) UITableView *recentlyViewedTableView;

@property (nonatomic, strong) RecentlyViewedBlogs *recentlyViewed;

@end

static NSString * const RecentlyViewedCellIdentifier = @"RecentlyViewedCellIdentifier";

@implementation BlogSelectViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _recentlyViewed = [RecentlyViewedBlogs new];
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // Creating views
    _blogNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _blogNameLabel.text = NSLocalizedString(@"blogSelect.blogNameLabel", nil);
    _blogNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    _blogNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_blogNameLabel];
    
    _blogNameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _blogNameTextField.placeholder = NSLocalizedString(@"blogSelect.blogNamePlaceholder", nil);
    _blogNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _blogNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _blogNameTextField.returnKeyType = UIReturnKeyGo;
    _blogNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _blogNameTextField.delegate = self;
    _blogNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_blogNameTextField];
    
    _goButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_goButton setTitle:NSLocalizedString(@"blogSelect.goButtonTitle", nil) forState:UIControlStateNormal];
    [_goButton addTarget:self action:@selector(onGoButton) forControlEvents:UIControlEventTouchUpInside];
    _goButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_goButton];
    
    _recentlyViewedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _recentlyViewedLabel.text = NSLocalizedString(@"blogSelect.recentlyViewedLabel", nil);
    _recentlyViewedLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    _recentlyViewedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_recentlyViewedLabel];
    
    _recentlyViewedTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _recentlyViewedTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_recentlyViewedTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RecentlyViewedCellIdentifier];
    _recentlyViewedTableView.dataSource = self;
    _recentlyViewedTableView.delegate = self;
    _recentlyViewedTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_recentlyViewedTableView];
    
    // Adding constraints
    CGFloat defaultDistance = 20.0;
    NSLayoutYAxisAnchor *topAnchor = [self.topLayoutGuide bottomAnchor];
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    NSArray *constraints = @[
                             [_blogNameLabel.topAnchor constraintEqualToAnchor:topAnchor constant:defaultDistance],
                             [_blogNameLabel.leftAnchor constraintEqualToAnchor:margins.leftAnchor],
                             [_blogNameLabel.rightAnchor constraintEqualToAnchor:margins.rightAnchor],
                             
                             [_blogNameTextField.topAnchor constraintEqualToAnchor:_blogNameLabel.bottomAnchor constant:defaultDistance],
                             [_blogNameTextField.leftAnchor constraintEqualToAnchor:margins.leftAnchor],
                             
                             [_goButton.leftAnchor constraintEqualToAnchor:_blogNameTextField.rightAnchor constant:defaultDistance],
                             [_goButton.rightAnchor constraintEqualToAnchor:margins.rightAnchor],
                             [_goButton.firstBaselineAnchor constraintEqualToAnchor:_blogNameTextField.firstBaselineAnchor],
                             
                             [_recentlyViewedLabel.leftAnchor constraintEqualToAnchor:margins.leftAnchor],
                             [_recentlyViewedLabel.topAnchor constraintEqualToAnchor:_blogNameTextField.bottomAnchor constant:defaultDistance * 1.5],
                             [_recentlyViewedLabel.rightAnchor constraintEqualToAnchor:margins.rightAnchor],
                             
                             [_recentlyViewedTableView.leftAnchor constraintEqualToAnchor:margins.leftAnchor],
                             [_recentlyViewedTableView.topAnchor constraintEqualToAnchor:_recentlyViewedLabel.bottomAnchor constant:defaultDistance],
                             [_recentlyViewedTableView.rightAnchor constraintEqualToAnchor:margins.rightAnchor],
                             [_recentlyViewedTableView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor constant:-defaultDistance]
                             ];
    
    for (NSLayoutConstraint *c in constraints) {
        [c setActive:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController setHidesBarsOnSwipe:YES];
    [self.recentlyViewedTableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self onGoButton];
    
    return NO;
}

- (void)onGoButton {
    NSString *blogName = self.blogNameTextField.text;
    [self goToBlogWithName:blogName];
}

- (void)goToBlogWithName:(NSString *)blogName {
    if ([self.delegate respondsToSelector:@selector(blogSelectViewController:didSelectBlogName:)]) {
        [self.delegate blogSelectViewController:self didSelectBlogName:blogName];
    }
    
    [self.recentlyViewed addBlog:blogName];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.blogNameTextField resignFirstResponder];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recentlyViewed.getBlogNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecentlyViewedCellIdentifier forIndexPath:indexPath];
    NSString *blogName = self.recentlyViewed.getBlogNames[indexPath.item];
    cell.textLabel.text = blogName;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *blogName = self.recentlyViewed.getBlogNames[indexPath.item];
    [self goToBlogWithName:blogName];
}

@end
