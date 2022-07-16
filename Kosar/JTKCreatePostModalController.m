//
//  JTKCreatePostModalController.m
//  Kosar
//
//  Created by ByteDance on 15/6/22.
//

#import "JTKCreatePostModalController.h"

#import "JTKCreatePostEditorController.h"

NSString * const kTitle = @"New Post";
NSString * const kCreateBarButtonTitle = @"Create";

@interface JTKCreatePostModalController ()

@property (nonatomic) JTKCreatePostEditorController *createPostEditorController;

@end

@implementation JTKCreatePostModalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *closeBarButtonItem =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose
                                                          target:self.modalDelegate
                                                          action:@selector(reactToCloseButtonTap)];
    UIBarButtonItem *createBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kCreateBarButtonTitle
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(executeForCreateButtonTap)];
    self.createPostEditorController = [[JTKCreatePostEditorController alloc] init];
    self.createPostEditorController.navigationItem.leftBarButtonItem = closeBarButtonItem;
    self.createPostEditorController.title = kTitle;
    self.createPostEditorController.navigationItem.rightBarButtonItem = createBarButtonItem;
    [self pushViewController:self.createPostEditorController animated:nil];
}


- (void)executeForCreateButtonTap {
    if ([self.createPostEditorController hasValidPost]) {
        [self.createPostEditorController createPost];
        [self.modalDelegate reactToCreateButtonTapWithValidPost];
    } else {
        [self.modalDelegate reactToCreateButtonTapWithInvalidPost];
    }
}


@end
