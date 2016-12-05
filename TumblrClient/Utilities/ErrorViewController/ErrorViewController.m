//
//  ErrorViewController.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import "ErrorViewController.h"

@interface ErrorViewController ()

@property (nonatomic, copy) NSString *messageTitle;
@property (nonatomic, copy) NSString *messageBody;
@property (nonatomic, copy) NSString *buttonTitle;

@end

static const CGFloat defaultDistance = 10.0;

@implementation ErrorViewController

- (instancetype)initWithMessageTitle:(NSString *)messageTitle messageBody:(NSString *)messageBody buttonTitle:(NSString *)buttonTitle {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _messageTitle = messageTitle;
        _messageBody = messageBody;
        _buttonTitle = buttonTitle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *messageTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel *messageBodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    messageTitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    messageBodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    messageTitleLabel.text = self.messageTitle;
    messageBodyLabel.text = self.messageBody;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[messageTitleLabel, messageBodyLabel]];
    stackView.spacing = defaultDistance;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackView];
    
    if (self.buttonTitle) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:self.buttonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonTap) forControlEvents:UIControlEventTouchUpInside];
        [stackView addArrangedSubview:button];
    }
    
    [[stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
}

- (void)onButtonTap {
    if ([self.delegate respondsToSelector:@selector(errorViewControllerButtonTapped:)]) {
        [self.delegate errorViewControllerButtonTapped:self];
    }
}

@end
