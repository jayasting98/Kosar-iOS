//
//  JTKModalHandler.m
//  Kosar
//
//  Created by ByteDance on 27/7/22.
//

#import "JTKModalHandler.h"

@interface JTKModalHandler ()

@end

@implementation JTKModalHandler

- (void)presentAnimated:(BOOL)animated withCompletionHandler:(void (^)(void))completion {
    if ([self.modalViewController isBeingPresented]) {
        return;
    }
    [self.presentingViewController presentViewController:self.modalViewController
                                                animated:animated
                                              completion:completion];
}

- (void)dismissAnimated:(BOOL)animated withCompletionHandler:(void (^)(void))completion {
    [self.presentingViewController dismissViewControllerAnimated:animated completion:completion];
}

@end
