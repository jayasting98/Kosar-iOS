//
//  JTKSessionsService.h
//  Kosar
//
//  Created by ByteDance on 24/7/22.
//

#import <Foundation/Foundation.h>

@class JTKUsernameCredentials;
@class JTKSession;

@interface JTKSessionsService : NSObject

+ (instancetype)sharedInstance;

- (void)createSessionUsingUsernameCredentials:(JTKUsernameCredentials *)usernameCredentials
                       withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
                       withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
                           withSuccessHandler:(void (^)(JTKSession *))successHandler;

@end
