//
//  JTKApiService.m
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import "JTKApiService.h"

#import "JTKAuthService.h"

static NSString * const kServerUrlBuildSettingKey = @"SERVER_URL";

static NSString * const kHttpPostMethod = @"POST";

static NSString * const kContentTypeHeader = @"Content-Type";
static NSString * const kJsonContentType = @"application/json";

static NSString * const kAuthorizationHeaderField = @"Authorization";
static NSString * const kBearerAuthorizationHeaderValueTemplate = @"Bearer %@";

@interface JTKApiRequestManager : NSObject

@end

@interface JTKApiRequestManager ()

@property (nonatomic, readonly) void (^completionHandler)(NSData *, NSURLResponse *, NSError *);

@property (nonatomic) NSURLRequest *request;
@property (nonatomic) void (^clientErrorHandler)(NSError *);
@property (nonatomic) void (^serverErrorHandler)(NSHTTPURLResponse *);
@property (nonatomic) void (^successHandler)(NSData *);

@end

@implementation JTKApiRequestManager

- (void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {
    void (^completionHandler)(NSData *, NSURLResponse *, NSError *);
    completionHandler = ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (self.clientErrorHandler != nil) {
                self.clientErrorHandler(error);
            }
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
            if (self.serverErrorHandler != nil) {
                self.serverErrorHandler(httpResponse);
            }
            return;
        }
        if (self.successHandler == nil) {
            return;
        }
        self.successHandler(data);
    };
    return completionHandler;
}

@end

@interface JTKApiRequestConfiguration ()

@property (nonatomic) NSString *method;
@property (nonatomic) NSString *path;

@end

@implementation JTKApiRequestConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _queryItems = [[NSArray alloc] init];
        _withAuthorization = YES;
    }
    return self;
}

@end

@interface JTKApiService ()

@property (nonatomic, readonly) NSString *baseUrlString;

@end

@implementation JTKApiService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)postAtPath:(NSString *)path
        withConfigurationSpecifier:(void (^)(JTKApiRequestConfiguration *))specifyRequestConfiguration {
    [self requestWithMethod:kHttpPostMethod atPath:path withConfigurationSpecifier:specifyRequestConfiguration];
}

- (void)requestWithMethod:(NSString *)method
                            atPath:(NSString *)path
        withConfigurationSpecifier:(void (^)(JTKApiRequestConfiguration *))specifyRequestConfiguration {
    JTKApiRequestConfiguration *requestConfiguration = [[JTKApiRequestConfiguration alloc] init];
    requestConfiguration.method = method;
    requestConfiguration.path = path;
    specifyRequestConfiguration(requestConfiguration);
    void (^requestManagerHandler)(JTKApiRequestManager *) = ^(JTKApiRequestManager *requestManager) {
        [self sendRequestFromRequestManager:requestManager];
    };
    [self buildRequestManagerWithConfiguration:requestConfiguration withHandler:requestManagerHandler];
}

- (void)buildRequestManagerWithConfiguration:(JTKApiRequestConfiguration *)requestConfiguration
                                 withHandler:(void (^)(JTKApiRequestManager *))requestManagerHandler {
    NSMutableString *urlString = [NSMutableString stringWithString:self.baseUrlString];
    [urlString appendString:requestConfiguration.path];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:urlString];
    [urlComponents setQueryItems:requestConfiguration.queryItems];
    NSURL *url = [urlComponents URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:requestConfiguration.method];
    [request setValue:kJsonContentType forHTTPHeaderField:kContentTypeHeader];
    [request setHTTPBody:requestConfiguration.body];
    JTKApiRequestManager *requestManager = [[JTKApiRequestManager alloc] init];
    requestManager.request = request;
    requestManager.clientErrorHandler = requestConfiguration.clientErrorHandler;
    requestManager.serverErrorHandler = requestConfiguration.serverErrorHandler;
    requestManager.successHandler = requestConfiguration.successHandler;
    if (![requestConfiguration isWithAuthorization]) {
        requestManagerHandler(requestManager);
        return;
    }
    void (^bearerTokenHandler)(NSString *) = ^(NSString *bearerToken) {
        NSString *authorizationHeaderValue =
                [NSString stringWithFormat:kBearerAuthorizationHeaderValueTemplate, bearerToken];
        [request setValue:authorizationHeaderValue forHTTPHeaderField:kAuthorizationHeaderField];
        requestManagerHandler(requestManager);
    };
    [[JTKAuthService sharedInstance] getBearerTokenWithHandler:bearerTokenHandler];
}

- (void)sendRequestFromRequestManager:(JTKApiRequestManager *)requestManager {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestManager.request
                                                completionHandler:requestManager.completionHandler];
    [dataTask resume];
}

- (NSString *)baseUrlString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:kServerUrlBuildSettingKey];
}

@end
