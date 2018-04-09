//
//  ZJDiscoverRecommendHeadView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendHeadView.h"

@interface ZJDiscoverRecommendHeadView ()

/** 容器 */
@property (nonatomic, strong) UIView *mainView;
/** 图标 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 布局按钮 */
@property (nonatomic, strong) UIButton *styleButton;

@end

@implementation ZJDiscoverRecommendHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor appGraySpaceColor];
    }
    return self;
}

- (void)clickChangeStyle:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.changeStyleBlock) {
        self.changeStyleBlock(button.selected);
    }
}

- (void)setIsShow:(BOOL)isShow
{
    if (isShow) {
        self.styleButton.hidden = NO;
    }else{
        self.styleButton.hidden = YES;
    }
}
- (void)setHeadModel:(ZJDiscoverHeadModel *)headModel
{
    _headModel = headModel;
    self.titleLabel.text = headModel.title;
    self.iconImageView.image = headModel.icon;
}
#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(2);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self.mainView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mainView);
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
        [self.mainView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(8);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _titleLabel;
}

- (UIButton *)styleButton
{
    if (!_styleButton) {
        _styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_styleButton setImage:[UIImage imageNamed:@"switch_to_double"] forState:UIControlStateNormal];
        [_styleButton setImage:[UIImage imageNamed:@"switch_to_signal"] forState:UIControlStateSelected];
        [_styleButton addTarget:self action:@selector(clickChangeStyle:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_styleButton];
        [_styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _styleButton;
}
@end
