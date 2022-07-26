//
//  JTKUsersService.m
//  Kosar
//
//  Created by ByteDance on 26/7/22.
//

#import "JTKUsersService.h"

#import "JTKApiService.h"
#import "JTKUser.h"

static NSString * const kBaseUsersPath = @"/users";

static NSString * const kCreateUserRelativePath = @"/";

static NSString * const kEmailAddressCreateUserRequestKey = @"emailAddress";
static NSString * const kUsernameCreateUserRequestKey = @"username";
static NSString * const kPasswordCreateUserRequestKey = @"password";

static NSString * const kUserIdCreateUserResponseKey = @"userId";
static NSString * const kEmailAddressCreateUserResponseKey = @"emailAddress";
static NSString * const kUsernameCreateUserResponseKey = @"username";
static NSString * const kDateTimeCreatedCreateUserResponseKey = @"dateTimeCreated";

@interface JTKUsersService ()

@end

@implementation JTKUsersService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)createCompletePathWithRelativePath:(NSString *)relativePath {
    NSMutableString *completePath = [NSMutableString stringWithString:kBaseUsersPath];
    [completePath appendString:relativePath];
    return completePath;
}

- (void)createUser:(JTKUser *)user
        withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
        withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
            withSuccessHandler:(void (^)(JTKUser *))successHandler {
    NSDictionary *createUserRequestDictionary = @{
        kEmailAddressCreateUserRequestKey: user.emailAddress,
        kUsernameCreateUserRequestKey: user.username,
        kPasswordCreateUserRequestKey: user.password,
    };
    NSData *createUserRequestData = [NSJSONSerialization dataWithJSONObject:createUserRequestDictionary
                                                                    options:0
                                                                      error:nil];
    void (^successDataHandler)(NSData *) = ^(NSData *data) {
        if (!successHandler) {
            return;
        }
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        JTKUser *createdUser = [[JTKUser alloc] init];
        createdUser.userId = responseDataDictionary[kUserIdCreateUserResponseKey];
        createdUser.emailAddress = responseDataDictionary[kEmailAddressCreateUserResponseKey];
        createdUser.username = responseDataDictionary[kUsernameCreateUserResponseKey];
        createdUser.dateTimeCreated = responseDataDictionary[kDateTimeCreatedCreateUserResponseKey];
        successHandler(createdUser);
    };
    NSString *completePath = [self createCompletePathWithRelativePath:kCreateUserRelativePath];
    [[JTKApiService sharedInstance] postToPath:completePath
                                      withBody:createUserRequestData
                        withClientErrorHandler:clientErrorHandler
                        withServerErrorHandler:serverErrorHandler
                            withSuccessHandler:successDataHandler];
}

@end
