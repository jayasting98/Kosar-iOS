//
//  JTKLoginController.m
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import "JTKLoginController.h"

#import "JTKContainerSchemeHelper.h"

#import "Masonry.h"
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialTextControls+OutlinedTextFields.h"

static CGFloat const kMargin = 16;
static CGFloat const kYGutter = 16;

static NSString * const kUsernameTextFieldLabelText = @"Username";
static NSString * const kPasswordTextFieldLabelText = @"Password";
static NSString * const kSignInButtonLabelText = @"Sign In";

@interface JTKLoginController ()

@property (nonatomic) MDCOutlinedTextField *usernameTextField;
@property (nonatomic) MDCOutlinedTextField *passwordTextField;
@property (nonatomic) MDCButton *signInButton;

@end

@implementation JTKLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self buildUsernameTextField];
    [self buildPasswordTextField];
    [self buildSignInButton];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutUsernameTextField];
    [self layoutPasswordTextField];
    [self layoutSignInButton];
}


- (void)buildUsernameTextField {
    self.usernameTextField = [[MDCOutlinedTextField alloc] init];
    [self.view addSubview:self.usernameTextField];
    self.usernameTextField.label.text = kUsernameTextFieldLabelText;
}


- (void)layoutUsernameTextField {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    [self.usernameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view).with.insets(margin);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
}


- (void)buildPasswordTextField {
    self.passwordTextField = [[MDCOutlinedTextField alloc] init];
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.label.text = kPasswordTextFieldLabelText;
    self.passwordTextField.secureTextEntry = YES;
}


- (void)layoutPasswordTextField {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    [self.passwordTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view).with.insets(margin);
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(kYGutter);
    }];
}


- (void)buildSignInButton {
    self.signInButton = [[MDCButton alloc] init];
    [self.view addSubview:self.signInButton];
    [self.signInButton setTitle:kSignInButtonLabelText forState:UIControlStateNormal];
    [self.signInButton applyContainedThemeWithScheme:[JTKContainerSchemeHelper getContainerScheme]];
}


- (void)layoutSignInButton {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, 0, 0, kMargin);
    [self.signInButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.insets(margin);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(kYGutter);
    }];
}


@end
