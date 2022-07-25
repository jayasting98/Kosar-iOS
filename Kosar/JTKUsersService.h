//
//  JTKUsersService.h
//  Kosar
//
//  Created by ByteDance on 26/7/22.
//

#import <Foundation/Foundation.h>

@class JTKUser;

@interface JTKUsersService : NSObject

+ (instancetype)sharedInstance;

- (void)createUser:(JTKUser *)user
    withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
    withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
        withSuccessHandler:(void (^)(JTKUser *))successHandler;

@end
