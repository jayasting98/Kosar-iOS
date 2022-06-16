//
//  JTKCreatePostEditorViewModel.m
//  Kosar
//
//  Created by ByteDance on 16/6/22.
//

#import "JTKCreatePostEditorViewModel.h"

@interface JTKCreatePostEditorViewModel ()

@end

@implementation JTKCreatePostEditorViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _text = [[NSString alloc] init];
    }
    return self;
}


- (BOOL)hasValidPost {
    return YES;
}


- (void)createPost {
    NSLog(@"Creating post with text \"%@\".", self.text);
}


@end
