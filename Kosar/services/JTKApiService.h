//
//  JTKApiService.h
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import <Foundation/Foundation.h>

@interface JTKApiRequestConfiguration : NSObject

@property (nonatomic) NSArray<NSURLQueryItem *> *queryItems;
@property (nonatomic, getter=isWithAuthorization) BOOL withAuthorization;
@property (nonatomic) NSData *body;
@property (nonatomic) void (^clientErrorHandler)(NSError *);
@property (nonatomic) void (^serverErrorHandler)(NSHTTPURLResponse *);
@property (nonatomic) void (^successHandler)(NSData *);

@end

@interface JTKApiService : NSObject

+ (instancetype)sharedInstance;

- (void)postAtPath:(NSString *)path
    withConfigurationSpecifier:(void (^)(JTKApiRequestConfiguration *configuration))specifyRequestConfiguration;

@end
