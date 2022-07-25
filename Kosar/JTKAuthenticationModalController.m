//
//  JTKAuthenticationModalController.m
//  Kosar
//
//  Created by ByteDance on 25/7/22.
//

#import "JTKAuthenticationModalController.h"

#import "JTKSignInController.h"

@interface JTKAuthenticationModalController ()

@property (nonatomic) JTKSignInController *signInController;

@end

@implementation JTKAuthenticationModalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInController = [[JTKSignInController alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self switchToSignInController];
}


- (void)switchToSignInController {
    NSArray<UIViewController *> *viewControllers = @[self.signInController];
    [self setViewControllers:viewControllers animated:YES];
}


@end
