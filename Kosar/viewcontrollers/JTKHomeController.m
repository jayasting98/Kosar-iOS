//
//  JTKHomeController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKHomeController.h"

#import "JTKAuthService.h"
#import "JTKPostSectionController.h"
#import "JTKPostsViewModel.h"

#import <IGListKit/IGListKit.h>

static NSString * const kProfileIconImageName = @"person-person_symbol";

static NSString * const kSignOutProfileMenuElementTitle = @"Sign Out";

@interface JTKHomeController () <IGListAdapterDataSource>

@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) IGListAdapter *adapter;

@property (nonatomic) JTKPostsViewModel *postsViewModel;

@end

@implementation JTKHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postsViewModel = [[JTKPostsViewModel alloc] init];
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    [self buildProfileBarButton];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}


- (void)buildProfileBarButton {
    UIImage *profileIcon = [UIImage imageNamed:kProfileIconImageName];
    UIAction *signOutAction = [UIAction actionWithTitle:kSignOutProfileMenuElementTitle
                                                  image:nil
                                             identifier:nil
                                                handler:^(__kindof UIAction * _Nonnull action) {
        [[JTKAuthService sharedInstance] signOut];
    }];
    NSArray<UIMenuElement *> *profileMenuChildren = @[
        signOutAction,
    ];
    UIMenu *profileMenu = [UIMenu menuWithChildren:profileMenuChildren];
    UIBarButtonItem *profileBarButtonItem = [[UIBarButtonItem alloc] initWithImage:profileIcon menu:profileMenu];
    self.navigationItem.leftBarButtonItem = profileBarButtonItem;
}


- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.postsViewModel.posts;
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[JTKPostSectionController alloc] init];
}


- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}


@end
