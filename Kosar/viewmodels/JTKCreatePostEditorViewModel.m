//
//  JTKCreatePostEditorViewModel.m
//  Kosar
//
//  Created by ByteDance on 16/6/22.
//

#import "JTKCreatePostEditorViewModel.h"

#import "JTKPost.h"
#import "JTKPostsService.h"

@interface JTKCreatePostEditorViewModel ()

@end

@implementation JTKCreatePostEditorViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _message = [[NSString alloc] init];
    }
    return self;
}

- (BOOL)hasValidPost {
    return YES;
}

- (void)createPost {
    JTKPost *post = [[JTKPost alloc] init];
    post.message = self.message;
    [[JTKPostsService sharedInstance] createPost:post
                          withClientErrorHandler:nil
                          withServerErrorHandler:nil
                              withSuccessHandler:nil];
}

@end
