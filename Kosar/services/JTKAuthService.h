//
//  JTKAuthService.h
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import <Foundation/Foundation.h>

@protocol JTKAuthenticationStateObserver <NSObject>

- (void)reactToSignIn;
- (void)reactToSignOut;

@end

@interface JTKAuthService : NSObject

@property (nonatomic, readonly, getter=isSignedIn) BOOL signedIn;

+ (instancetype)sharedInstance;

- (void)getBearerTokenWithHandler:(void (^)(NSString *))bearerTokenHandler;
- (void)addAuthenticationStateObserver:(id<JTKAuthenticationStateObserver>)observer;
- (void)removeAuthenticationStateObserver:(id<JTKAuthenticationStateObserver>)observer;
- (void)signInUsingAuthenticationToken:(NSString *)authenticationToken;
- (void)signOut;

@end
