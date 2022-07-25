//
//  JTKAuthenticationModalController.m
//  Kosar
//
//  Created by ByteDance on 25/7/22.
//

#import "JTKAuthenticationModalController.h"

#import "JTKSignInController.h"
#import "JTKSignUpController.h"

@interface JTKAuthenticationModalController () <JTKSignInModalDelegate>

@property (nonatomic) JTKSignInController *signInController;
@property (nonatomic) JTKSignUpController *signUpController;

@end

@implementation JTKAuthenticationModalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInController = [[JTKSignInController alloc] init];
    self.signInController.modalDelegate = self;
    self.signUpController = [[JTKSignUpController alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self switchToSignInController];
}


- (void)reactToGoSignUpButtonTap {
    [self switchToSignUpController];
}


- (void)switchToSignInController {
    NSArray<UIViewController *> *viewControllers = @[self.signInController];
    [self setViewControllers:viewControllers animated:YES];
}


- (void)switchToSignUpController {
    NSArray<UIViewController *> *viewControllers = @[self.signUpController];
    [self setViewControllers:viewControllers animated:YES];
}


@end
