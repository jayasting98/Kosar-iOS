//
//  JTKViewUtil.m
//  Kosar
//
//  Created by ByteDance on 27/7/22.
//

#import "JTKViewUtil.h"

#import <UIKit/UIKit.h>

@interface JTKViewUtil ()

@end

@implementation JTKViewUtil

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)enableHidingKeyboardWhenTappingElsewhereInView:(UIView *)effectiveAreaView {
    UITapGestureRecognizer *tapGestureRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(hideKeyboardWhenTappingElsewhere:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [effectiveAreaView addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyboardWhenTappingElsewhere:(UITapGestureRecognizer *)sender {
    [sender.view endEditing:YES];
}

@end
