//
//  JTKApiService.m
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import "JTKApiService.h"

static NSString * const kServerUrlBuildSettingKey = @"SERVER_URL";

static NSString * const kHttpPostMethod = @"POST";

static NSString * const kContentTypeHeader = @"Content-Type";

static NSString * const kJsonContentType = @"application/json";

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


- (void)sendRequest:(NSURLRequest *)request
    withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
    withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
        withSuccessHandler:(void (^)(NSData *))successHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    void (^completionHandler)(NSData *, NSURLResponse *, NSError *);
    completionHandler = ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (clientErrorHandler) {
                clientErrorHandler(error);
            }
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
            if (serverErrorHandler) {
                serverErrorHandler(httpResponse);
            }
            return;
        }
        if (!successHandler) {
            return;
        }
        successHandler(data);
    };
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}


- (void)postToPath:(NSString *)path
                withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems
                      withBody:(NSData *)body
        withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
        withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
            withSuccessHandler:(void (^)(NSData *))successHandler {
    NSMutableString *urlString = [NSMutableString stringWithString:self.baseUrlString];
    [urlString appendString:path];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:urlString];
    [urlComponents setQueryItems:queryItems];
    NSURL *url = [urlComponents URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:kHttpPostMethod];
    [request setValue:kJsonContentType forHTTPHeaderField:kContentTypeHeader];
    [request setHTTPBody:body];
    [self sendRequest:request
        withClientErrorHandler:clientErrorHandler
        withServerErrorHandler:serverErrorHandler
            withSuccessHandler:successHandler];
}


- (void)postToPath:(NSString *)path
                      withBody:(NSData *)body
        withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
        withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
            withSuccessHandler:(void (^)(NSData *))successHandler {
    NSArray<NSURLQueryItem *> *queryItems = @[];
    [self postToPath:path
                withQueryItems:queryItems
                      withBody:body
        withClientErrorHandler:clientErrorHandler
        withServerErrorHandler:serverErrorHandler
            withSuccessHandler:successHandler];
}


- (NSString *)baseUrlString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:kServerUrlBuildSettingKey];
}


@end
