//
//  JTKPostViewModel.h
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import <Foundation/Foundation.h>

#import <IGListKit/IGListKit.h>

@class JTKPost;

@interface JTKPostViewModel : NSObject <IGListDiffable>

@property (nonatomic, readonly) NSString *message;

- (instancetype)initWithPost:(JTKPost *)post;

@end
