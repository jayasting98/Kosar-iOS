//
//  JTKSignInController.m
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import "JTKSignInController.h"

#import "JTKContainerSchemeHelper.h"
#import "JTKSignInViewModel.h"
#import "JTKViewUtil.h"

#import "Masonry.h"
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialTextControls+OutlinedTextFields.h"

static CGFloat const kMargin = 16;
static CGFloat const kYGutter = 16;

static NSString * const kUsernameTextFieldLabelText = @"Username";
static NSString * const kPasswordTextFieldLabelText = @"Password";
static NSString * const kSignInButtonLabelText = @"Sign In";
static NSString * const kGoSignUpButtonLabelText = @"I do not have an account";

static NSInteger const kUsernameTextFieldTag = 1;
static NSInteger const kPasswordTextFieldTag = 2;

static CGFloat const kGoSignUpButtonLabelFontSize = 12;

@interface JTKSignInController () <UITextFieldDelegate>

@property (nonatomic) JTKSignInViewModel *viewModel;

@property (nonatomic) MDCOutlinedTextField *usernameTextField;
@property (nonatomic) MDCOutlinedTextField *passwordTextField;
@property (nonatomic) MDCButton *signInButton;
@property (nonatomic) UIButton *goSignUpButton;

@end

@implementation JTKSignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[JTKSignInViewModel alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    [[JTKViewUtil sharedInstance] enableHidingKeyboardWhenTappingElsewhereInView:self.view];
    [self buildUsernameTextField];
    [self buildPasswordTextField];
    [self buildSignInButton];
    [self buildGoSignUpButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetTextFields];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutUsernameTextField];
    [self layoutPasswordTextField];
    [self layoutSignInButton];
    [self layoutGoSignUpButton];
}

- (void)buildUsernameTextField {
    self.usernameTextField = [[MDCOutlinedTextField alloc] init];
    [self.view addSubview:self.usernameTextField];
    self.usernameTextField.label.text = kUsernameTextFieldLabelText;
    self.usernameTextField.delegate = self;
    self.usernameTextField.tag = kUsernameTextFieldTag;
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

- (void)buildSignInButton {
    self.signInButton = [[MDCButton alloc] init];
    [self.view addSubview:self.signInButton];
    [self.signInButton setTitle:kSignInButtonLabelText forState:UIControlStateNormal];
    [self.signInButton applyContainedThemeWithScheme:[JTKContainerSchemeHelper getContainerScheme]];
    [self.signInButton addTarget:self.viewModel action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSignInButton {
    UIEdgeInsets margin = UIEdgeInsetsMake(0, 0, 0, kMargin);
    [self.signInButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.insets(margin);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(kYGutter);
    }];
}

- (void)buildGoSignUpButton {
    self.goSignUpButton = [[UIButton alloc] init];
    [self.view addSubview:self.goSignUpButton];
    [self.goSignUpButton setTitle:kGoSignUpButtonLabelText forState:UIControlStateNormal];
    [self.goSignUpButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.goSignUpButton.titleLabel setFont:[UIFont systemFontOfSize:kGoSignUpButtonLabelFontSize]];
    [self.goSignUpButton addTarget:self.modalDelegate
                            action:@selector(reactToGoSignUpButtonTap)
                  forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutGoSignUpButton {
    [self.goSignUpButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.signInButton.mas_bottom).with.offset(kYGutter);
    }];
}

- (BOOL)textField:(UITextField *)textField
        shouldChangeCharactersInRange:(NSRange)range
                    replacementString:(NSString *)string {
    NSString *updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (textField.tag) {
        case kUsernameTextFieldTag:
            self.viewModel.username = updatedString;
            break;
        case kPasswordTextFieldTag:
            self.viewModel.password = updatedString;
            break;
    }
    return YES;
}

- (void)resetTextFields {
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
}

@end
