//
//  JTKPostCell.m
//  Kosar
//
//  Created by ByteDance on 2/6/22.
//

#import "JTKPostCell.h"

@interface JTKPostCell ()

@property (nonatomic) UILabel *textLabel;

@end

@implementation JTKPostCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews {
    self.textLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.textLabel];
}


- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat margin = 8.0;
    CGRect bounds = self.contentView.bounds;
    self.textLabel.frame = CGRectMake(margin, 0, bounds.size.width - margin * 2, bounds.size.height);
}


- (void)setText:(NSString *)text {
    _text = [text copy];

    self.textLabel.text = _text;
}


@end

