//
//  JTKSignInViewModel.m
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import "JTKSignInViewModel.h"

#import "JTKAuthService.h"
#import "JTKSession.h"
#import "JTKSessionsService.h"
#import "JTKUsernameCredentials.h"

@interface JTKSignInViewModel ()

@end

@implementation JTKSignInViewModel

- (void)signIn {
    JTKUsernameCredentials *usernameCredentials = [[JTKUsernameCredentials alloc] init];
    usernameCredentials.username = self.username;
    usernameCredentials.password = self.password;
    void (^successHandler)(JTKSession *) = ^(JTKSession *session) {
        [[JTKAuthService sharedInstance] signInUsingAuthenticationToken:session.authenticationToken];
    };
    [[JTKSessionsService sharedInstance] createSessionUsingUsernameCredentials:usernameCredentials
                                                        withClientErrorHandler:nil
                                                        withServerErrorHandler:nil
                                                            withSuccessHandler:successHandler];
}

@end
