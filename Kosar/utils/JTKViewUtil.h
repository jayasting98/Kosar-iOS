//
//  JTKViewUtil.h
//  Kosar
//
//  Created by ByteDance on 27/7/22.
//

#import <Foundation/Foundation.h>

@class UIView;

@interface JTKViewUtil : NSObject

+ (instancetype)sharedInstance;

- (void)enableHidingKeyboardWhenTappingElsewhereInView:(UIView *)effectiveAreaView;

@end
