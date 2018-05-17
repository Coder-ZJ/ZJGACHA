//
//  ZJPostDetailHeaderView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailHeaderView.h"

@interface ZJPostDetailHeaderView ()

@end

@implementation ZJPostDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        [self bottomLine];
    }
    return self;
}
- (void)setHeadModel:(ZJDiscoverHeadModel *)headModel
{
    _headModel = headModel;
    self.titleLabel.text = headModel.title;
    self.iconImageView.image = headModel.icon;
}

#pragma mark -----------------lazy-----------------
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [ZJColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(8);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _titleLabel;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [ZJColor appBottomLineColor];
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomLine;
}

@end
