//
//  JTKSignUpController.m
//  Kosar
//
//  Created by ByteDance on 25/7/22.
//

#import "JTKSignUpController.h"

#import "Masonry.h"
#import "MaterialTextControls+OutlinedTextFields.h"

static CGFloat const kMargin = 16;

static NSString * const kUsernameTextFieldLabelText = @"Username";

@interface JTKSignUpController ()

@property (nonatomic) MDCOutlinedTextField *usernameTextField;

@end

@implementation JTKSignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self buildUsernameTextField];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutUsernameTextField];
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


@end
