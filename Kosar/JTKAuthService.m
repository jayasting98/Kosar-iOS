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

@property (nonatomic) NSMutableSet<id<JTKAuthenticationStateObserver>> *authenticationStateObservers;

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
        _authenticationStateObservers = [[NSMutableSet alloc] init];
        [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
            if (user) {
                for (id<JTKAuthenticationStateObserver> observer in self.authenticationStateObservers) {
                    [observer reactToSignIn];
                }
            } else {
                for (id<JTKAuthenticationStateObserver> observer in self.authenticationStateObservers) {
                    [observer reactToSignOut];
                }
            }
        }];
    }
    return self;
}


- (void)addAuthenticationStateObserver:(id<JTKAuthenticationStateObserver>)observer {
    [self.authenticationStateObservers addObject:observer];
}


- (void)removeAuthenticationStateObserver:(id<JTKAuthenticationStateObserver>)observer {
    [self.authenticationStateObservers removeObject:observer];
}


- (void)signInUsingAuthenticationToken:(NSString *)authenticationToken {
    [[FIRAuth auth] signInWithCustomToken:authenticationToken completion:nil];
}


- (BOOL)isSignedIn {
    return [FIRAuth auth].currentUser != nil;
}


@end
