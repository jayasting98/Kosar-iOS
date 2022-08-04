//
//  JTKPostViewModel.m
//  Kosar
//
//  Created by ByteDance on 10/6/22.
//

#import "JTKPostViewModel.h"

#import "JTKPost.h"
#import "JTKUser.h"

#import <IGListKit/IGListKit.h>

static NSInteger const kMaximumUnitsTimeSinceCreation = 1;
static NSString * const kTimeSinceCreationTemplate = @"%@ ago";

@interface JTKPostViewModel () <IGListDiffable>

@property (nonatomic) JTKPost *post;

@end

@implementation JTKPostViewModel

- (instancetype)initWithPost:(JTKPost *)post {
    if (self = [super init]) {
        self.post = post;
    }
    return self;
}

- (nonnull id<NSObject>)diffIdentifier {
    return self.post.postId;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    return [self isEqual:object];
}

- (NSUInteger)hash {
    return [self.post.postId hash];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[JTKPostViewModel class]]) {
        return NO;
    }
    JTKPostViewModel *other = object;
    return [self.post.postId isEqual:other.post.postId];
}

- (NSString *)authorUsername {
    return self.post.author.username;
}

- (NSString *)message {
    return self.post.message;
}

- (NSString *)timeSinceCreation {
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
    formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
        | NSCalendarUnitMinute | NSCalendarUnitSecond;
    formatter.maximumUnitCount = kMaximumUnitsTimeSinceCreation;
    NSString *elapsedTimeString = [formatter stringFromDate:self.post.dateTimeCreated toDate:[NSDate date]];
    NSString *timeSinceCreation = [[NSString alloc] initWithFormat:kTimeSinceCreationTemplate, elapsedTimeString];
    return timeSinceCreation;
}

@end
