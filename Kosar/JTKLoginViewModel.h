//
//  JTKLoginViewModel.h
//  Kosar
//
//  Created by ByteDance on 23/7/22.
//

#import <Foundation/Foundation.h>

@interface JTKLoginViewModel : NSObject

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

- (void)signIn;

@end
