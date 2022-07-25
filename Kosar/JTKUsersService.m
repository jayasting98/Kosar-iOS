//
//  JTKUsersService.m
//  Kosar
//
//  Created by ByteDance on 26/7/22.
//

#import "JTKUsersService.h"

static NSString * const kBaseUsersPath = @"/users";

@interface JTKUsersService ()

@end

@implementation JTKUsersService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (NSString *)createCompletePathWithRelativePath:(NSString *)relativePath {
    NSMutableString *completePath = [NSMutableString stringWithString:kBaseUsersPath];
    [completePath appendString:relativePath];
    return completePath;
}


@end
