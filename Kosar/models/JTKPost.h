//
//  JTKPost.h
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import <Foundation/Foundation.h>

@class JTKUser;

@interface JTKPost : NSObject

@property (nonatomic) NSString *postId;
@property (nonatomic) NSString *message;
@property (nonatomic) JTKUser *author;
@property (nonatomic) NSDate *dateTimeCreated;

+ (JTKPost *)parsePostResponseDictionary:(NSDictionary *)postResponseDictionary;

@end
