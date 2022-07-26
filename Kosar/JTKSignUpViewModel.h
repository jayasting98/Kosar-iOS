//
//  JTKSignUpViewModel.h
//  Kosar
//
//  Created by ByteDance on 26/7/22.
//

#import <Foundation/Foundation.h>

@interface JTKSignUpViewModel : NSObject

@property (nonatomic) NSString *emailAddress;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

- (void)signUp;

@end
