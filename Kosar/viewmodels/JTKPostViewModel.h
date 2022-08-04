//
//  JTKPostViewModel.h
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import <Foundation/Foundation.h>

@class JTKPost;

@interface JTKPostViewModel : NSObject

@property (nonatomic, readonly) NSString *authorUsername;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSString *timeSinceCreation;

- (instancetype)initWithPost:(JTKPost *)post;

@end
