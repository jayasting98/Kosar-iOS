//
//  JTKAuthService.h
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import <Foundation/Foundation.h>

@protocol JTKLoginStatusObserver <NSObject>

- (void)reactToLogin;

- (void)reactToLogout;

@end

@interface JTKAuthService : NSObject

+ (instancetype)sharedInstance;

- (void)addLoginStatusObserver:(id<JTKLoginStatusObserver>)loginStatusObserver;
- (void)removeLoginStatusObserver:(id<JTKLoginStatusObserver>)loginStatusObserver;

@end
