//
//  ZJDiscoverRecommendMoreTitleCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendMoreTitleCell.h"

@implementation ZJDiscoverRecommendMoreTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self iconImageView];
    }
    return self;
}

#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];
    }
    return _mainView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor appMainColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mainView).with.offset(5);
            make.centerX.mas_equalTo(self.mainView.mas_centerX).with.offset(-10);
        }];
        [_nameLabel.superview layoutIfNeeded];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"discovery_icon_jump~iphone"];
        _iconImageView.image = image;
        [self.mainView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.mainView).with.offset(5);
        }];
    }
    return _iconImageView;
}
@end
