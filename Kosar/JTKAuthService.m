//
//  JTKAuthService.m
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import "JTKAuthService.h"

#import "FirebaseAuth.h"

#ifdef DEBUG
static NSString * const kEmulatorHostUrl = @"localhost";
static NSInteger const kEmulatorPort = 9099;
#endif

@interface JTKAuthService ()

@property (nonatomic) NSMutableSet<id<JTKLoginStatusObserver>> *loginStatusObservers;

@end

@implementation JTKAuthService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
#ifdef DEBUG
        [[FIRAuth auth] useEmulatorWithHost:kEmulatorHostUrl port:kEmulatorPort];
#endif
        _loginStatusObservers = [[NSMutableSet alloc] init];
        [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
            if (user) {
                for (id<JTKLoginStatusObserver> loginStatusObserver in self.loginStatusObservers) {
                    [loginStatusObserver reactToLogin];
                }
            } else {
                for (id<JTKLoginStatusObserver> loginStatusObserver in self.loginStatusObservers) {
                    [loginStatusObserver reactToLogout];
                }
            }
        }];
    }
    return self;
}


- (void)addLoginStatusObserver:(id<JTKLoginStatusObserver>)loginStatusObserver {
    [self.loginStatusObservers addObject:loginStatusObserver];
}


- (void)removeLoginStatusObserver:(id<JTKLoginStatusObserver>)loginStatusObserver {
    [self.loginStatusObservers removeObject:loginStatusObserver];
}


- (void)signInUsingAuthenticationToken:(NSString *)authenticationToken {
    [[FIRAuth auth] signInWithCustomToken:authenticationToken completion:nil];
}


- (BOOL)isLoggedIn {
    return [FIRAuth auth].currentUser != nil;
}


@end
