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
    withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}


- (void)postToPath:(NSString *)path
                 withBody:(NSData *)body
    withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    NSMutableString *urlString = [NSMutableString stringWithString:self.baseUrlString];
    [urlString appendString:path];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:kHttpPostMethod];
    [request setValue:kJsonContentType forHTTPHeaderField:kContentTypeHeader];
    [request setHTTPBody:body];
    [self sendRequest:request withCompletionHandler:completionHandler];
}


- (NSString *)baseUrlString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:kServerUrlBuildSettingKey];
}


@end
