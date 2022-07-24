//
//  JTKMainController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKMainController.h"

#import "JTKAuthService.h"
#import "JTKContainerSchemeHelper.h"
#import "JTKCreatePostModalController.h"
#import "JTKHomeController.h"
#import "JTKLoginController.h"

#import "Masonry.h"
#import "MaterialBottomNavigation+Theming.h"
#import "MaterialButtons.h"
#include <MaterialComponents/MDCContainerScheme.h>

NSString * const kFloatingActionButtonIcon = @"add-add_symbol";

CGFloat const kFloatingActionButtonMarginBottom = 16;
CGFloat const kFloatingActionButtonMarginRight = 16;
CGSize const kFloatingActionButtonSize = {56, 56};


@interface JTKCreatePostModalHandler : NSObject <JTKCreatePostModalDelegate>

@property (nonatomic) UIViewController *presentingViewController;

@property (nonatomic) JTKCreatePostModalController *createPostModalController;

@end


@implementation JTKCreatePostModalHandler

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController {
    self = [super init];
    if (self) {
        _presentingViewController = presentingViewController;
        _createPostModalController = [[JTKCreatePostModalController alloc] init];
        _createPostModalController.modalDelegate = self;
        _createPostModalController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


- (void)present {
    [self.presentingViewController presentViewController:self.createPostModalController animated:YES completion:nil];
}


- (void)reactToCloseButtonTap {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)reactToCreateButtonTapWithInvalidPost {
    NSLog(@"Reacting to invalid post.");
}


- (void)reactToCreateButtonTapWithValidPost {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end


@interface JTKLoginModalHandler : NSObject <JTKLoginStatusObserver>

@property (nonatomic, weak) UIViewController *presentingViewController;

@property (nonatomic) JTKLoginController *loginController;

@end

@implementation JTKLoginModalHandler

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController {
    self = [super init];
    if (self) {
        _presentingViewController = presentingViewController;
        _loginController = [[JTKLoginController alloc] init];
        _loginController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


- (void)present {
    [self.presentingViewController presentViewController:self.loginController animated:YES completion:nil];
}


- (void)reactToLogin {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)reactToLogout {
    [self present];
}


@end


@interface JTKMainController ()

@property (nonatomic) JTKLoginModalHandler *loginModalHandler;

@property (nonatomic) MDCBottomNavigationBar *bottomNavigationBar;
@property (nonatomic) MDCFloatingButton *floatingActionButton;

@end

@implementation JTKMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginModalHandler = [[JTKLoginModalHandler alloc] initWithPresentingViewController:self];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self buildBottomNavigationBar];
    self.viewControllers = @[
        [self createTabWithViewController:[[JTKHomeController alloc] init]],
        [self createTabWithViewController:[[JTKHomeController alloc] init]],
        [self createTabWithViewController:[[JTKHomeController alloc] init]]
    ];
    [self buildFloatingActionButton];
}


- (void)buildBottomNavigationBar {
    self.bottomNavigationBar = [[MDCBottomNavigationBar alloc] init];
    [self.view addSubview:self.bottomNavigationBar];
    self.bottomNavigationBar.titleVisibility = MDCBottomNavigationBarTitleVisibilitySelected;
    self.bottomNavigationBar.alignment = MDCBottomNavigationBarAlignmentJustifiedAdjacentTitles;
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"Home"
                                                           image:[UIImage imageNamed:@"timeline-timeline_symbol"]
                                                             tag:0];
    UITabBarItem *homeItem2 = [[UITabBarItem alloc] initWithTitle:@"Home2"
                                                            image:[UIImage imageNamed:@"timeline-timeline_symbol"]
                                                              tag:1];
    UITabBarItem *homeItem3 = [[UITabBarItem alloc] initWithTitle:@"Home3"
                                                            image:[UIImage imageNamed:@"timeline-timeline_symbol"]
                                                              tag:2];
    self.bottomNavigationBar.items = @[homeItem, homeItem2, homeItem3];
    self.bottomNavigationBar.selectedItem = homeItem;
    self.bottomNavigationBar.delegate = self;
}


- (void)layoutBottomNavigationBar {
    CGSize size = [self.bottomNavigationBar sizeThatFits:self.view.bounds.size];
    CGRect bottomNavigationBarFrame = CGRectMake(
        0,
        self.view.bounds.size.height - size.height,
        size.width,
        size.height
    );
    bottomNavigationBarFrame.size.height += self.view.safeAreaInsets.bottom;
    bottomNavigationBarFrame.origin.y -= self.view.safeAreaInsets.bottom;
    self.bottomNavigationBar.frame = bottomNavigationBarFrame;
}


- (void)buildFloatingActionButton {
    self.floatingActionButton = [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
    [self.view addSubview:self.floatingActionButton];
    UIImage *floatingActionButtonImage = [UIImage imageNamed:kFloatingActionButtonIcon];
    [self.floatingActionButton setImage:floatingActionButtonImage forState:UIControlStateNormal];
    [self.floatingActionButton addTarget:self
                                  action:@selector(presentCreatePostModal)
                        forControlEvents:UIControlEventTouchUpInside];
}


- (void)layoutFloatingActionButton {
    UIEdgeInsets margin = self.view.safeAreaInsets;
    margin.right += kFloatingActionButtonMarginRight;
    [self.floatingActionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(kFloatingActionButtonSize);
        make.bottom.equalTo(self.bottomNavigationBar.mas_top).with.offset(-kFloatingActionButtonMarginBottom);
        make.right.equalTo(self.view.mas_right).with.offset(-margin.right);
    }];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutBottomNavigationBar];
    [self layoutFloatingActionButton];
}


- (void)adjustAdditionalSafeAreaInsetsDueToBottomNavigationBar {
    UIEdgeInsets newSafeArea = self.additionalSafeAreaInsets;
    newSafeArea.bottom += self.bottomNavigationBar.frame.size.height - self.tabBar.frame.size.height;
    self.selectedViewController.additionalSafeAreaInsets = newSafeArea;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self adjustAdditionalSafeAreaInsetsDueToBottomNavigationBar];
    [self enableReactingToLogins];
    [self presentLoginModalIfNecessary];
}


- (void)enableReactingToLogins {
    [[JTKAuthService sharedInstance] addLoginStatusObserver:self.loginModalHandler];
}


- (void)presentLoginModalIfNecessary {
    if ([[JTKAuthService sharedInstance] isLoggedIn]) {
        return;
    }
    [self.loginModalHandler present];
}


- (UINavigationController *)createTabWithViewController:(UIViewController *)viewController {
    UINavigationController *tabViewController = [
        [UINavigationController alloc] initWithRootViewController:viewController
    ];
    return tabViewController;
}


- (void)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar didSelectItem:(UITabBarItem *)item {
    self.selectedIndex = item.tag;
}


- (void)presentCreatePostModal {
    JTKCreatePostModalHandler *modalHandler = [[JTKCreatePostModalHandler alloc] initWithPresentingViewController:self];
    [modalHandler present];
}


@end
