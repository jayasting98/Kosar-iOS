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

static NSString * const kPostIdPostDataKey = @"postId";
static NSString * const kPostMessagePostDataKey = @"message";

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
        kPostMessagePostDataKey: post.text,
    };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDataDictionary options:0 error:nil];
    void (^successDataHandler)(NSData *) = ^(NSData *data){
        if (!successHandler) {
            return;
        }
        NSDictionary *responseDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        JTKPost *createdPost = [[JTKPost alloc] init];
        createdPost.postId = responseDataDictionary[kPostIdPostDataKey];
        createdPost.text = responseDataDictionary[kPostMessagePostDataKey];
        successHandler(createdPost);
    };
    NSString *completePath = [self createCompletePathWithRelativePath:kCreatePostRelativePath];
    [[JTKApiService sharedInstance] postToPath:completePath
                                      withBody:postData
                        withClientErrorHandler:clientErrorHandler
                        withServerErrorHandler:serverErrorHandler
                            withSuccessHandler:successDataHandler];
}


@end
