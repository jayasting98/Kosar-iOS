//
//  JTKHomeController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKHomeController.h"

#import "JTKPostSectionController.h"
#import "JTKPostsViewModel.h"

#import <IGListKit/IGListKit.h>
#import "Masonry.h"
#import "MaterialButtons.h"

NSString * const kFloatingActionButtonIcon = @"add-add_symbol";

CGFloat const kFloatingActionButtonMarginBottom = 16;
CGFloat const kFloatingActionButtonMarginRight = 16;
CGSize const kFloatingActionButtonSize = {56, 56};

@interface JTKHomeController () <IGListAdapterDataSource>

@property (nonatomic) MDCFloatingButton *floatingActionButton;
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
    [self setupFloatingActionButton];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutFloatingActionButton];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}


- (void)setupFloatingActionButton {
    self.floatingActionButton = [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
    [self.view addSubview:self.floatingActionButton];
    UIImage *floatingActionButtonImage = [UIImage imageNamed:kFloatingActionButtonIcon];
    [self.floatingActionButton setImage:floatingActionButtonImage forState:UIControlStateNormal];
}


- (void)layoutFloatingActionButton {
    UIEdgeInsets margin = self.view.safeAreaInsets;
    margin.bottom += kFloatingActionButtonMarginBottom;
    margin.right += kFloatingActionButtonMarginRight;
    [self.floatingActionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(kFloatingActionButtonSize);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-margin.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-margin.right);
    }];
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
