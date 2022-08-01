//
//  JTKPostsViewModel.m
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import "JTKPostsViewModel.h"

#import "JTKPost.h"
#import "JTKPostViewModel.h"
#import "JTKPostsService.h"

@interface JTKPostsViewModel ()

@property (nonatomic) NSArray<JTKPost *> *postModels;

@end

@implementation JTKPostsViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.postModels = [[NSArray alloc] init];
    }
    return self;
}

- (NSArray<JTKPostViewModel *> *)posts {
    NSMutableArray<JTKPostViewModel *> *posts = [[NSMutableArray alloc] init];
    for (JTKPost *post in self.postModels) {
        JTKPostViewModel *postViewModel = [[JTKPostViewModel alloc] initWithPost:post];
        [posts addObject:postViewModel];
    }
    return posts;
}

- (void)getPostsWithCompletionHandler:(void (^)(void))completionHandler {
    void (^successHandler)(NSArray<JTKPost *> *posts) = ^(NSArray<JTKPost *> *posts) {
        self.postModels = posts;
        completionHandler();
    };
    [[JTKPostsService sharedInstance] getPostsWithClientErrorHandler:nil
                                              withServerErrorHandler:nil
                                                  withSuccessHandler:successHandler];
}

@end
