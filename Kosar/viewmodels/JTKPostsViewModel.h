//
//  JTKPostsViewModel.h
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import <Foundation/Foundation.h>

#import <IGListKit/IGListKit.h>

@class JTKPostViewModel;

@interface JTKPostsViewModel : NSObject

@property (nonatomic, readonly) NSArray<JTKPostViewModel *> *posts;

- (void)resetData;
- (void)getPostsWithCompletionHandler:(void (^)(void))completionHandler;

@end
