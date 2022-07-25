//
//  JTKSignUpController.h
//  Kosar
//
//  Created by ByteDance on 25/7/22.
//

#import <UIKit/UIKit.h>

@protocol JTKSignUpModalDelegate <NSObject>

- (void)reactToGoSignInButtonTap;

@end

@interface JTKSignUpController : UIViewController

@property (nonatomic, weak) id<JTKSignUpModalDelegate> modalDelegate;

@end
