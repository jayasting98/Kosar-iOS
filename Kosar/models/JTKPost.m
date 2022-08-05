//
//  JTKPost.m
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import "JTKPost.h"

#import "JTKUser.h"

static NSString * const kDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";

static NSString * const kPostIdResponseKey = @"postId";
static NSString * const kPostMessageResponseKey = @"message";
static NSString * const kAuthorResponseKey = @"author";
static NSString * const kAuthorUserIdResponseKey = @"userId";
static NSString * const kAuthorUsernameResponseKey = @"username";
static NSString * const kAuthorDateTimeCreatedResponseKey = @"dateTimeCreated";
static NSString * const kPostDateTimeCreatedResponseKey = @"dateTimeCreated";

@interface JTKPost ()

@end

@implementation JTKPost

+ (JTKPost *)parsePostResponseDictionary:(NSDictionary *)postResponseDictionary {
    JTKPost *post = [[JTKPost alloc] init];
    JTKUser *author = [[JTKUser alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kDateFormat];
    NSDictionary *postAuthorResponseDictionary = postResponseDictionary[kAuthorResponseKey];
    author.userId = postAuthorResponseDictionary[kAuthorUserIdResponseKey];
    author.username = postAuthorResponseDictionary[kAuthorUsernameResponseKey];
    author.dateTimeCreated =
            [dateFormatter dateFromString:postAuthorResponseDictionary[kAuthorDateTimeCreatedResponseKey]];
    post.postId = postResponseDictionary[kPostIdResponseKey];
    post.message = postResponseDictionary[kPostMessageResponseKey];
    post.author = author;
    post.dateTimeCreated = [dateFormatter dateFromString:postResponseDictionary[kPostDateTimeCreatedResponseKey]];
    return post;
}

@end
