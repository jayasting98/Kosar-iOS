//
//  JTKContainerSchemeHelper.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKContainerSchemeHelper.h"

@implementation JTKContainerSchemeHelper

+ (MDCContainerScheme *)getContainerScheme {
    static dispatch_once_t pred;
    static MDCContainerScheme *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDCContainerScheme alloc] init];
        sharedInstance.colorScheme.primaryColor = UIColor.blueColor;
    });
    return sharedInstance;
}

@end
