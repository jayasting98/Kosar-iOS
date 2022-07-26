//
//  JTKUser.h
//  Kosar
//
//  Created by ByteDance on 26/7/22.
//

#import <Foundation/Foundation.h>

@interface JTKUser : NSObject

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *emailAddress;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSDate *dateTimeCreated;

@end
