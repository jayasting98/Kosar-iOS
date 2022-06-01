//
//  JTKMainController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKMainController.h"

#import "JTKHomeController.h"

@interface JTKMainController ()

@end

@implementation JTKMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.viewControllers = @[
        [self createTabWithTitle:@"first" withViewController:[[JTKHomeController alloc] init]],
        [self createTabWithTitle:@"second" withViewController:[[JTKHomeController alloc] init]],
        [self createTabWithTitle:@"third" withViewController:[[JTKHomeController alloc] init]]
    ];
    [self.tabBar setBackgroundColor:[UIColor grayColor]];
}


- (UINavigationController *)createTabWithTitle:(NSString *)title withViewController:(UIViewController *)viewController {
    UINavigationController *tabViewController = [
        [UINavigationController alloc] initWithRootViewController:viewController
    ];
    tabViewController.title = title;
    return tabViewController;
}


@end

