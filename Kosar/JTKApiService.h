//
//  JTKApiService.h
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import <Foundation/Foundation.h>

@interface JTKApiService : NSObject

+ (instancetype)sharedInstance;

- (void)postToPath:(NSString *)path
            withQueryItems:(NSArray<NSURLQueryItem *> *)queryItems
                  withBody:(NSData *)body
    withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
    withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
        withSuccessHandler:(void (^)(NSData *))successHandler;

- (void)postToPath:(NSString *)path
                  withBody:(NSData *)body
    withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
    withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
        withSuccessHandler:(void (^)(NSData *))successHandler;

@end
