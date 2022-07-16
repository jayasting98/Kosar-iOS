//
//  JTKPostsService.m
//  Kosar
//
//  Created by ByteDance on 15/7/22.
//

#import "JTKPostsService.h"

static NSString * const kBasePostsPath = @"/posts";

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


@end
