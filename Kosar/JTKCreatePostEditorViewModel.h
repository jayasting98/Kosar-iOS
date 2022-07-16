//
//  JTKCreatePostEditorViewModel.h
//  Kosar
//
//  Created by ByteDance on 16/6/22.
//

#import <Foundation/Foundation.h>

@interface JTKCreatePostEditorViewModel : NSObject

@property (nonatomic) NSString *text;

- (BOOL)hasValidPost;

- (void)createPost;

@end
