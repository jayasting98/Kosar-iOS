//
//  JTKSessionsService.m
//  Kosar
//
//  Created by ByteDance on 24/7/22.
//

#import "JTKSessionsService.h"

#import "JTKApiService.h"
#import "JTKSession.h"
#import "JTKUsernameCredentials.h"

static NSString * const kBaseSessionsPath = @"/sessions";

static NSString * const kCreateSessionRelativePath = @"/";

static NSString * const kCredentialsQueryName = @"credentials";
static NSString * const kUsernameCredentialsQueryValue = @"username";

static NSString * const kUsernameCredentialsUsernameDataKey = @"username";
static NSString * const kUsernameCredentialsPasswordDataKey = @"password";

static NSString * const kAuthenticationTokenSessionKey = @"authenticationToken";

@interface JTKSessionsService ()

@end

@implementation JTKSessionsService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)createCompletePathWithRelativePath:(NSString *)relativePath {
    NSMutableString *completePath = [NSMutableString stringWithString:kBaseSessionsPath];
    [completePath appendString:relativePath];
    return completePath;
}

- (void)createSessionUsingUsernameCredentials:(JTKUsernameCredentials *)usernameCredentials
                       withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
                       withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
                           withSuccessHandler:(void (^)(JTKSession *))successHandler {
    NSDictionary *usernameCredentialsDataDictionary = @{
        kUsernameCredentialsUsernameDataKey: usernameCredentials.username,
        kUsernameCredentialsPasswordDataKey: usernameCredentials.password,
    };
    NSData *usernameCredentialsData = [NSJSONSerialization dataWithJSONObject:usernameCredentialsDataDictionary
                                                                      options:0
                                                                        error:nil];
    void (^successDataHandler)(NSData *) = ^(NSData *data) {
        if (!successHandler) {
            return;
        }
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        JTKSession *createdSession = [[JTKSession alloc] init];
        createdSession.authenticationToken = responseDataDictionary[kAuthenticationTokenSessionKey];
        successHandler(createdSession);
    };
    NSString *completePath = [self createCompletePathWithRelativePath:kCreateSessionRelativePath];
    NSURLQueryItem *credentialsQuery = [NSURLQueryItem queryItemWithName:kCredentialsQueryName
                                                                   value:kUsernameCredentialsQueryValue];
    NSArray<NSURLQueryItem *> *queryItems = @[credentialsQuery];
    [[JTKApiService sharedInstance] postToPath:completePath
                                withQueryItems:queryItems
                                      withBody:usernameCredentialsData
                        withClientErrorHandler:clientErrorHandler
                        withServerErrorHandler:serverErrorHandler
                            withSuccessHandler:successDataHandler];
}

@end
