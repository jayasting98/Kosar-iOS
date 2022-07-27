//
//  JTKModalHandler.h
//  Kosar
//
//  Created by ByteDance on 27/7/22.
//

#import <UIKit/UIKit.h>

@interface JTKModalHandler<__covariant P : UIViewController *, __covariant M : UIViewController *> : NSObject

@property (nonatomic) P presentingViewController;
@property (nonatomic) M modalViewController;

- (void)presentAnimated:(BOOL)animated withCompletionHandler:(void (^)(void))completion;
- (void)dismissAnimated:(BOOL)animated withCompletionHandler:(void (^)(void))completion;

@end
