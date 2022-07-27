//
//  JTKPostSectionController.m
//  Kosar
//
//  Created by ByteDance on 2/6/22.
//

#import "JTKPostSectionController.h"

#import "JTKPostCell.h"
#import "JTKPostViewModel.h"

@interface JTKPostSectionController ()

@property (nonatomic) JTKPostViewModel *postViewModel;

@end

@implementation JTKPostSectionController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    CGFloat width = self.collectionContext.containerSize.width;
    CGFloat height = 40;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    JTKPostCell *cell = [self.collectionContext dequeueReusableCellOfClass:JTKPostCell.class
                                                      forSectionController:self
                                                                   atIndex:index];
    cell.message = self.postViewModel.message;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    NSAssert([object isKindOfClass:[JTKPostViewModel class]], @"%@ should be a PostViewModel instance.", object);
    self.postViewModel = (JTKPostViewModel *) object;
}

@end
