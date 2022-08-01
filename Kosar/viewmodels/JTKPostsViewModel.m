//
//  JTKPostsViewModel.m
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import "JTKPostsViewModel.h"

#import "JTKPost.h"
#import "JTKPostViewModel.h"

@interface JTKPostsViewModel ()

@property (nonatomic) NSArray<JTKPost *> *postModels;

@end

@implementation JTKPostsViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.postModels = [JTKPostsViewModel createPlaceholderPosts];
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

+ (NSArray<JTKPost *> *)createPlaceholderPosts {
    NSMutableArray<JTKPost *> *list = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++) {
        NSString *newObject = [NSString stringWithFormat:@"%d", arc4random()];
        JTKPost *post = [[JTKPost alloc] init];
        post.postId = [NSString stringWithFormat:@"%d", i];
        post.message = newObject;
        [list addObject:post];
    }
    return list;
}

@end
