//
//  JTKSignInController.h
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import <UIKit/UIKit.h>

@protocol JTKSignInModalDelegate <NSObject>

- (void)reactToGoSignUpButtonTap;

@end

@interface JTKSignInController : UIViewController

@property (nonatomic, weak) id<JTKSignInModalDelegate> modalDelegate;

@end
