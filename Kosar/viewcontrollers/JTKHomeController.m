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

#import "Masonry.h"
#import <IGListKit/IGListKit.h>

static NSString * const kProfileIconImageName = @"person-person_symbol";

static NSString * const kSignOutProfileMenuElementTitle = @"Sign Out";

@interface JTKHomeController () <IGListAdapterDataSource>

@property (nonatomic) UICollectionView *postsCollectionView;

@property (nonatomic) IGListAdapter *postsAdapter;

@property (nonatomic) JTKPostsViewModel *postsViewModel;

@end

@implementation JTKHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postsViewModel = [[JTKPostsViewModel alloc] init];
    [self buildPostsCollectionView];
    [self setupPostsAdapter];
    [self buildProfileBarButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPosts];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutPostsCollectionView];
}

- (void)buildPostsCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.postsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.postsCollectionView];
}

- (void)layoutPostsCollectionView {
    [self.postsCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupPostsAdapter {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.postsAdapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.postsAdapter.collectionView = self.postsCollectionView;
    self.postsAdapter.dataSource = self;
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
    return (NSArray<id<IGListDiffable>> *) self.postsViewModel.posts;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[JTKPostSectionController alloc] init];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

- (void)getPosts {
    void (^completionHandler)(void) = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.postsAdapter performUpdatesAnimated:YES completion:nil];
        });
    };
    [self.postsViewModel getPostsWithCompletionHandler:completionHandler];
}

@end
