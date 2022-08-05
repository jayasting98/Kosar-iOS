//
//  JTKPostsService.h
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import <Foundation/Foundation.h>

@class JTKPost;

@interface JTKPostsService : NSObject

+ (instancetype)sharedInstance;

- (void)createPost:(JTKPost *)post
    withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
    withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
        withSuccessHandler:(void (^)(JTKPost *))successHandler;

- (void)getPostsWithClientErrorHandler:(void (^)(NSError *))clientErrorHandler
                withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
                    withSuccessHandler:(void (^)(NSArray<JTKPost *> *))successHandler;

@end
