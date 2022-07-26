//
//  JTKContainerSchemeHelper.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKContainerSchemeHelper.h"

@implementation JTKContainerSchemeHelper

MDCContainerScheme *containerScheme;

+ (MDCContainerScheme *)getContainerScheme {
    if (!containerScheme) {
        containerScheme = [[MDCContainerScheme alloc] init];
        containerScheme.colorScheme.primaryColor = UIColor.blueColor;
    }
    return containerScheme;
}

@end
