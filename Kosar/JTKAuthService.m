//
//  JTKAuthService.m
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import "JTKAuthService.h"

@interface JTKAuthService ()

@end

@implementation JTKAuthService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
