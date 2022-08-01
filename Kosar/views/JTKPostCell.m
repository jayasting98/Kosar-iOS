//
//  JTKPostCell.m
//  Kosar
//
//  Created by ByteDance on 2/6/22.
//

#import "JTKPostCell.h"

@interface JTKPostCell ()

@property (nonatomic) UILabel *messageLabel;

@end

@implementation JTKPostCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.messageLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.messageLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 8.0;
    CGRect bounds = self.contentView.bounds;
    self.messageLabel.frame = CGRectMake(margin, 0, bounds.size.width - margin * 2, bounds.size.height);
}

- (void)setMessage:(NSString *)message {
    _message = [message copy];

    self.messageLabel.text = _message;
}

@end
