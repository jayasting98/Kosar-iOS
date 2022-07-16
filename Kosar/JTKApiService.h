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
                 withBody:(NSData *)body
    withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end
