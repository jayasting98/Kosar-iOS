//
//  JTKPostSectionController.m
//  Kosar
//
//  Created by ByteDance on 2/6/22.
//

#import "JTKPostSectionController.h"

#import "JTKPostCell.h"

@interface JTKPostSectionController ()

@property (nonatomic) NSString *object;

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
    cell.text = self.object;
    return cell;
}


- (void)didUpdateToObject:(id)object {
    self.object = [object description];
}


@end
