//
//  JTKCreatePostModalController.h
//  Kosar
//
//  Created by ByteDance on 15/6/22.
//

#import <UIKit/UIKit.h>

@protocol JTKCreatePostModalDelegate <NSObject>

- (void)reactToCloseButtonTap;

- (void)reactToCreateButtonTapWithInvalidPost;

- (void)reactToCreateButtonTapWithValidPost;

@end

@interface JTKCreatePostModalController : UINavigationController

@property (nonatomic) id<JTKCreatePostModalDelegate> modalDelegate;

@end
