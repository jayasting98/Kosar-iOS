//
//  JTKPostCell.m
//  Kosar
//
//  Created by ByteDance on 2/6/22.
//

#import "JTKPostCell.h"

#import "Masonry.h"

static UIEdgeInsets const kInsets = {8, 8, 8, 8};

@interface JTKPostCell ()

@property (nonatomic) UILabel *messageLabel;

@end

@implementation JTKPostCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)updateConstraints {
    [self updateMessageLabelConstraints];
    [super updateConstraints];
}

- (void)setupSubviews {
    [self setupMessageLabel];
}

- (void)setupMessageLabel {
    self.messageLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.messageLabel];
}

- (void)updateMessageLabelConstraints {
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(kInsets);
    }];
}

- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.height = size.height;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}

@end
