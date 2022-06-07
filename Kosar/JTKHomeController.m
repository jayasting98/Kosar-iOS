//
//  JTKHomeController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKHomeController.h"

#import "JTKPostSectionController.h"

#import <IGListKit/IGListKit.h>

@interface JTKHomeController () <IGListAdapterDataSource>

@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) IGListAdapter *adapter;

@end

@implementation JTKHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    self.adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}


- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    NSMutableArray<id<IGListDiffable>> *list = [[NSMutableArray alloc] initWithArray:@[@"Foo", @"Bar", @"Biz"]];
    for (int i = 0; i < 20; i++) {
        NSString *newObject = [NSString stringWithFormat:@"%d", arc4random()];
        [list addObject:newObject];
    }
    return list;
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[JTKPostSectionController alloc] init];
}


- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}


@end
