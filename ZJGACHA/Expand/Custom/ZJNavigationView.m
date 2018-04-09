//
//  ZJNavigationView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJNavigationView.h"

@interface ZJNavigationView ()

/** 底部分割线 */
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ZJNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        [self setupUI];
    }
    return self;

}
- (void)setupUI
{
    [self bottomLine];
}
- (void)setShowBottomLine:(BOOL)showBottomLine
{
    self.bottomLine.hidden = !showBottomLine;
}
#pragma mark -----------------点击事件-----------------
- (void)clickLeftButton
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
    if (self.leftButtonBlock) {
        self.leftButtonBlock();
    }
}
- (void)clickRightButton
{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}
- (void)clickCenterButton
{
    if (self.centerButtonBlock) {
        self.centerButtonBlock();
    }
}
#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor clearColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftButton.adjustsImageWhenHighlighted = NO;
        _leftButton.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_leftButton setTitleColor:[ZJColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_leftButton];
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.mainView.mas_centerY).with.offset((KStatusBarMargin + 20) / 2.0);
        }];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightButton.adjustsImageWhenHighlighted = NO;
        _rightButton.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_rightButton setTitleColor:[ZJColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_rightButton];
        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-5);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.leftButton);
        }];
    }
    return _rightButton;
}

- (UIButton *)centerButton
{
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _centerButton.adjustsImageWhenHighlighted = NO;
        _centerButton.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [_centerButton setTitleColor:[ZJColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_centerButton];
        [_centerButton addTarget:self action:@selector(clickCenterButton) forControlEvents:UIControlEventTouchUpInside];
        [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(kScreenWidth - (self.rightButton.width + 38) * 2);
            make.height.mas_equalTo(self.leftButton.mas_height);
            make.centerY.mas_equalTo(self.leftButton);
        }];
    }
    return _centerButton;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [ZJColor colorWithHexString:@"0xDCDCDC" withAlpha:1.0];
        [self.mainView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        [self.mainView bringSubviewToFront:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] init];

    }
    return _searchView;
}
@end
