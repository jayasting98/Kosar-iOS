//
//  JTKSignUpViewModel.m
//  Kosar
//
//  Created by ByteDance on 26/7/22.
//

#import "JTKSignUpViewModel.h"

#import "JTKAuthService.h"
#import "JTKSession.h"
#import "JTKSessionsService.h"
#import "JTKUser.h"
#import "JTKUsernameCredentials.h"
#import "JTKUsersService.h"

@interface JTKSignUpViewModel ()

@end

@implementation JTKSignUpViewModel

- (void)signUp {
    JTKUser *user = [[JTKUser alloc] init];
    user.emailAddress = self.emailAddress;
    user.username = self.username;
    user.password = self.password;
    void (^createSessionSuccessHandler)(JTKSession *) = ^(JTKSession *session) {
        [[JTKAuthService sharedInstance] signInUsingAuthenticationToken:session.authenticationToken];
    };
    void (^createUserSuccessHandler)(JTKUser *) = ^(JTKUser *user) {
        JTKUsernameCredentials *usernameCredentials = [[JTKUsernameCredentials alloc] init];
        usernameCredentials.username = self.username;
        usernameCredentials.password = self.password;
        [[JTKSessionsService sharedInstance] createSessionUsingUsernameCredentials:usernameCredentials
                                                            withClientErrorHandler:nil
                                                            withServerErrorHandler:nil
                                                                withSuccessHandler:createSessionSuccessHandler];
    };
    [[JTKUsersService sharedInstance] createUser:user
                          withClientErrorHandler:nil
                          withServerErrorHandler:nil
                              withSuccessHandler:createUserSuccessHandler];
}

@end
