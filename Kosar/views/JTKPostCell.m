//
//  JTKPostCell.m
//  Kosar
//
//  Created by ByteDance on 2/6/22.
//

#import "JTKPostCell.h"

#import "Masonry.h"

static UIEdgeInsets const kInsets = {8, 8, 8, 8};
static CGFloat const kYGutter = 8;

static CGFloat const kAuthorUsernameLabelFontSize = 14;
static CGFloat const kTimeSinceCreationLabelFontSize = 10;

@interface JTKPostCell ()

@property (nonatomic) UILabel *authorUsernameLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UILabel *timeSinceCreationLabel;

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
    [self updateAuthorUsernameLabelConstraints];
    [self updateMessageLabelConstraints];
    [self updateTimeSinceCreationLabelConstraints];
    [super updateConstraints];
}

- (void)setupSubviews {
    [self setupAuthorUsernameLabel];
    [self setupMessageLabel];
    [self setupTimeSinceCreationLabel];
}

- (void)setupAuthorUsernameLabel {
    self.authorUsernameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.authorUsernameLabel];
    self.authorUsernameLabel.font = [UIFont systemFontOfSize:kAuthorUsernameLabelFontSize];
}

- (void)setupMessageLabel {
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.numberOfLines = 0;
    [self.contentView addSubview:self.messageLabel];
}

- (void)setupTimeSinceCreationLabel {
    self.timeSinceCreationLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeSinceCreationLabel];
    self.timeSinceCreationLabel.font = [UIFont systemFontOfSize:kTimeSinceCreationLabelFontSize];
}

- (void)updateAuthorUsernameLabelConstraints {
    [self.authorUsernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.equalTo(self.contentView).with.insets(kInsets);
        make.trailing.lessThanOrEqualTo(self.contentView).with.insets(kInsets);
    }];
}

- (void)updateMessageLabelConstraints {
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorUsernameLabel.mas_bottom).with.offset(kYGutter);
        make.leading.and.trailing.equalTo(self.contentView).with.insets(kInsets);
    }];
}

- (void)updateTimeSinceCreationLabelConstraints {
    [self.timeSinceCreationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).with.offset(kYGutter);
        make.leading.and.bottom.equalTo(self.contentView).with.insets(kInsets);
        make.trailing.lessThanOrEqualTo(self.contentView).with.insets(kInsets);
    }];
}

- (void)setAuthorUsername:(NSString *)authorUsername {
    self.authorUsernameLabel.text = authorUsername;
}

- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
}

- (void)setTimeSinceCreation:(NSString *)timeSinceCreation {
    self.timeSinceCreationLabel.text = timeSinceCreation;
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
