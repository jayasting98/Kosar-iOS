//
//  JTKApiService.m
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import "JTKApiService.h"

static NSString * const kServerUrlBuildSettingKey = @"SERVER_URL";

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


- (NSString *)baseUrlString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:kServerUrlBuildSettingKey];
}


@end
