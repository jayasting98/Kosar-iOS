//
//  JTKSignUpController.m
//  Kosar
//
//  Created by ByteDance on 25/7/22.
//

#import "JTKSignUpController.h"

#import "JTKContainerSchemeHelper.h"
#import "JTKSignUpViewModel.h"

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
static NSString * const kGoSignInButtonLabelText = @"I already have an account";

static NSInteger const kEmailAddressTextFieldTag = 1;
static NSInteger const kUsernameTextFieldTag = 2;
static NSInteger const kPasswordTextFieldTag = 3;

static CGFloat const kGoSignInButtonLabelFontSize = 12;

@interface JTKSignUpController () <UITextFieldDelegate>

@property (nonatomic) JTKSignUpViewModel *viewModel;

@property (nonatomic) MDCOutlinedTextField *emailAddressTextField;
@property (nonatomic) MDCOutlinedTextField *usernameTextField;
@property (nonatomic) MDCOutlinedTextField *passwordTextField;
@property (nonatomic) MDCButton *signUpButton;
@property (nonatomic) UIButton *goSignInButton;

@end

@implementation JTKSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[JTKSignUpViewModel alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    [self enableDismissingKeyboardWhenTappingElsewhere];
    [self buildEmailAddressTextField];
    [self buildUsernameTextField];
    [self buildPasswordTextField];
    [self buildSignUpButton];
    [self buildGoSignInButton];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutEmailAddressTextField];
    [self layoutUsernameTextField];
    [self layoutPasswordTextField];
    [self layoutSignUpButton];
    [self layoutGoSignInButton];
}


- (void)buildEmailAddressTextField {
    self.emailAddressTextField = [[MDCOutlinedTextField alloc] init];
    [self.view addSubview:self.emailAddressTextField];
    self.emailAddressTextField.label.text = kEmailAddressTextFieldLabelText;
    self.emailAddressTextField.delegate = self;
    self.emailAddressTextField.tag = kEmailAddressTextFieldTag;
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


- (void)buildGoSignInButton {
    self.goSignInButton = [[UIButton alloc] init];
    [self.view addSubview:self.goSignInButton];
    [self.goSignInButton setTitle:kGoSignInButtonLabelText forState:UIControlStateNormal];
    [self.goSignInButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.goSignInButton.titleLabel setFont:[UIFont systemFontOfSize:kGoSignInButtonLabelFontSize]];
    [self.goSignInButton addTarget:self.modalDelegate
                            action:@selector(reactToGoSignInButtonTap)
                  forControlEvents:UIControlEventTouchUpInside];
}


- (void)layoutGoSignInButton {
    [self.goSignInButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.signUpButton.mas_bottom).with.offset(kYGutter);
    }];
}


- (BOOL)textField:(UITextField *)textField
        shouldChangeCharactersInRange:(NSRange)range
                    replacementString:(NSString *)string {
    NSString *updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (textField.tag) {
        case kEmailAddressTextFieldTag:
            self.viewModel.emailAddress = updatedString;
            break;
        case kUsernameTextFieldTag:
            self.viewModel.username = updatedString;
            break;
        case kPasswordTextFieldTag:
            self.viewModel.password = updatedString;
            break;
    }
    return YES;
}


- (void)enableDismissingKeyboardWhenTappingElsewhere {
    UITapGestureRecognizer *tapGestureRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(stopEditingWhenTappingElsewhere:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


- (void)stopEditingWhenTappingElsewhere:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


@end
