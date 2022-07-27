//
//  JTKPostViewModel.h
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import <Foundation/Foundation.h>

@class JTKPost;

@interface JTKPostViewModel : NSObject

@property (nonatomic, readonly) NSString *message;

- (instancetype)initWithPost:(JTKPost *)post;

@end
