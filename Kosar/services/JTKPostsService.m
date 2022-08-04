//
//  JTKPostsService.m
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import "JTKPostsService.h"

#import "JTKApiService.h"
#import "JTKPost.h"

static NSString * const kBasePostsPath = @"/posts";

static NSString * const kCreatePostRelativePath = @"/";
static NSString * const kGetPostsRelativePath = @"/";

static NSString * const kPostIdPostDataKey = @"postId";
static NSString * const kPostMessagePostDataKey = @"message";

static NSString * const kPostsGetPostsResponseKey = @"posts";

@interface JTKPostsService ()

@end

@implementation JTKPostsService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)createCompletePathWithRelativePath:(NSString *)relativePath {
    NSMutableString *completePath = [NSMutableString stringWithString:kBasePostsPath];
    [completePath appendString:relativePath];
    return completePath;
}

- (void)createPost:(JTKPost *)post
        withClientErrorHandler:(void (^)(NSError *))clientErrorHandler
        withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
            withSuccessHandler:(void (^)(JTKPost *))successHandler {
    NSDictionary *postDataDictionary = @{
        kPostMessagePostDataKey: post.message,
    };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDataDictionary options:0 error:nil];
    void (^successDataHandler)(NSData *) = ^(NSData *data) {
        if (!successHandler) {
            return;
        }
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        JTKPost *createdPost = [JTKPost parsePostResponseDictionary:responseDataDictionary];
        successHandler(createdPost);
    };
    NSString *completePath = [self createCompletePathWithRelativePath:kCreatePostRelativePath];
    [[JTKApiService sharedInstance] postAtPath:completePath
                    withConfigurationSpecifier:^(JTKApiRequestConfiguration *configuration) {
        configuration.body = postData;
        configuration.clientErrorHandler = clientErrorHandler;
        configuration.serverErrorHandler = serverErrorHandler;
        configuration.successHandler = successDataHandler;
    }];
}

- (void)getPostsWithClientErrorHandler:(void (^)(NSError *))clientErrorHandler
                withServerErrorHandler:(void (^)(NSHTTPURLResponse *))serverErrorHandler
                    withSuccessHandler:(void (^)(NSArray<JTKPost *> *))successHandler {
    void (^successDataHandler)(NSData *) = ^(NSData *data) {
        if (!successHandler) {
            return;
        }
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray<JTKPost *> *posts = [[NSMutableArray alloc] init];
        for (NSDictionary *postResponseDictionary in responseDataDictionary[kPostsGetPostsResponseKey]) {
            JTKPost *post = [JTKPost parsePostResponseDictionary:postResponseDictionary];
            [posts addObject:post];
        }
        successHandler(posts);
    };
    NSString *completePath = [self createCompletePathWithRelativePath:kGetPostsRelativePath];
    [[JTKApiService sharedInstance] getAtPath:completePath
                    withConfigurationSpecifier:^(JTKApiRequestConfiguration *configuration) {
        configuration.clientErrorHandler = clientErrorHandler;
        configuration.serverErrorHandler = serverErrorHandler;
        configuration.successHandler = successDataHandler;
    }];
}

@end
