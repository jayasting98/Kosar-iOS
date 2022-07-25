//
//  JTKSignUpController.m
//  Kosar
//
//  Created by ByteDance on 25/7/22.
//

#import "JTKSignUpController.h"

#import "JTKContainerSchemeHelper.h"

#import "Masonry.h"
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialTextControls+OutlinedTextFields.h"

static CGFloat const kMargin = 16;
static CGFloat const kYGutter = 16;

static NSString * const kEmailAddressTextFieldLabelText = @"Email Address";
static NSString * const kUsernameTextFieldLabelText = @"Username";
static NSString * const kPasswordTextFieldLabelText = @"Password";
static NSString * const kSignUpButtonLabelText = @"Sign Up";

@interface JTKSignUpController ()

@property (nonatomic) MDCOutlinedTextField *emailAddressTextField;
@property (nonatomic) MDCOutlinedTextField *usernameTextField;
@property (nonatomic) MDCOutlinedTextField *passwordTextField;
@property (nonatomic) MDCButton *signUpButton;

@end

@implementation JTKSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self buildEmailAddressTextField];
    [self buildUsernameTextField];
    [self buildPasswordTextField];
    [self buildSignUpButton];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutEmailAddressTextField];
    [self layoutUsernameTextField];
    [self layoutPasswordTextField];
    [self layoutSignUpButton];
}


- (void)buildEmailAddressTextField {
    self.emailAddressTextField = [[MDCOutlinedTextField alloc] init];
    [self.view addSubview:self.emailAddressTextField];
    self.emailAddressTextField.label.text = kEmailAddressTextFieldLabelText;
}


- (void)layoutEmailAddressTextField {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    [self.emailAddressTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view).with.insets(margin);
        make.bottom.equalTo(self.usernameTextField.mas_top).with.offset(-kYGutter);
    }];
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
    self.passwordTextField.delegate = self;
    self.passwordTextField.tag = kPasswordTextFieldTag;
}


- (void)layoutPasswordTextField {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    [self.passwordTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view).with.insets(margin);
        make.top.equalTo(self.usernameTextField.mas_bottom).with.offset(kYGutter);
    }];
}


- (void)buildSignUpButton {
    self.signUpButton = [[MDCButton alloc] init];
    [self.view addSubview:self.signUpButton];
    [self.signUpButton setTitle:kSignUpButtonLabelText forState:UIControlStateNormal];
    [self.signUpButton applyContainedThemeWithScheme:[JTKContainerSchemeHelper getContainerScheme]];
}


- (void)layoutSignUpButton {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, 0, 0, kMargin);
    [self.signUpButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.insets(margin);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(kYGutter);
    }];
}


@end
