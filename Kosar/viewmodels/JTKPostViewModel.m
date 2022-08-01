//
//  JTKPostViewModel.m
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import "JTKPostViewModel.h"

#import "JTKPost.h"

#import <IGListKit/IGListKit.h>

@interface JTKPostViewModel () <IGListDiffable>

@property (nonatomic) JTKPost *post;

@end

@implementation JTKPostViewModel

- (instancetype)initWithPost:(JTKPost *)post {
    if (self = [super init]) {
        self.post = post;
        _message = post.message;
    }
    return self;
}

- (nonnull id<NSObject>)diffIdentifier {
    return self.post.postId;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    return [self isEqual:object];
}

- (NSUInteger)hash {
    return [self.post.postId hash];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[JTKPostViewModel class]]) {
        return NO;
    }
    JTKPostViewModel *other = object;
    return [self.post.postId isEqual:other.post.postId];
}

@end
