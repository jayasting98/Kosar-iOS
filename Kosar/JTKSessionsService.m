//
//  JTKSessionsService.m
//  Kosar
//
//  Created by ByteDance on 24/7/22.
//

#import "JTKSessionsService.h"

@interface JTKSessionsService ()

@end

@implementation JTKSessionsService

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
