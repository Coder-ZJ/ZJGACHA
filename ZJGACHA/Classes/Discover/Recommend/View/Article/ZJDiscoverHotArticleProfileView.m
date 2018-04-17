//
//  ZJDiscoverHotArticleProfileView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotArticleProfileView.h"

@implementation ZJDiscoverHotArticleProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)praiseButtonEvent:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.praiseBlock) {
        self.praiseBlock(btn.selected);
    }
}

#pragma mark -----------------lazy-----------------

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIImageView *)thumb
{
    if (!_thumb) {
        _thumb = [[UIImageView alloc] init];
        _thumb.size = CGSizeMake(25, 25);
        _thumb.layer.cornerRadius = _thumb.size.width * 0.5;
        _thumb.layer.masksToBounds = YES;
        [self.mainView addSubview:_thumb];
        [_thumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.mainView);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return _thumb;
}

- (YYLabel *)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[YYLabel alloc] init];
        _nickLabel.textColor = [ZJColor blackColor];
        _nickLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumb.mas_right).with.offset(20);
            make.right.mas_equalTo(self.praiseButton.mas_left).with.offset(-20);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nickLabel;
}

- (UIButton *)praiseButton
{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.adjustsImageWhenHighlighted = NO;
        _praiseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateSelected];
        [self.mainView addSubview:_praiseButton];
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(_thumb.mas_centerY);
            make.height.mas_equalTo(_mainView.mas_height);
            make.width.mas_equalTo(60);
        }];
        [_praiseButton addTarget:self action:@selector(praiseButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseButton;
}

@end
