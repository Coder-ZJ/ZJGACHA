//
//  ZJDiscoverRecommendBannerCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendBannerCell.h"
#import "ZJDiscoverRankViewController.h"

@implementation ZJDiscoverRecommendBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self view];
    }
    return self;
}

- (ZJDiscoverRecommendBannerCellView *)view
{
    if (!_view) {
        _view = [[ZJDiscoverRecommendBannerCellView alloc] init];
        _view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickJumpRank:)];
        [_view addGestureRecognizer:tap];
        [self.contentView addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _view;
}

- (void)setBannerModel:(ZJDiscoverRecommendBannerModel *)bannerModel
{
    _bannerModel = bannerModel;
    [self.view rightImageView];
    [self.view.rightImageView setImageWithURL:[NSURL URLWithString:bannerModel.rightFull] placeholder:placeholderFailImage];
    [self.view.thumbImageView setImageWithURL:[NSURL URLWithString:bannerModel.headFull] placeholder:placeholderAvatarImage];
    self.view.nameLabel.text = [NSString stringWithFormat:@"@%@",bannerModel.authorName];
}

- (void)clickJumpRank:(UITapGestureRecognizer *)tap
{
    //跳转排行榜
    ZJDiscoverRankViewController *rankVC = [[ZJDiscoverRankViewController alloc] init];
    [self.viewController.navigationController pushViewController:rankVC animated:YES];
}
@end


@implementation ZJDiscoverRecommendBannerCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self leftImageView];
        [self bgImageView];
        [self topImageView];
    }
    return self;
}

#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.layer.masksToBounds = YES;
        _mainView.backgroundColor = [ZJColor appGraySpaceColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"discovery_banner_icon~iphone"];
        _leftImageView.image = image;
        [self.mainView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _leftImageView;
}
- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        [self.mainView addSubview:_rightImageView];
        [self.mainView sendSubviewToBack:_rightImageView];
        _rightImageView.backgroundColor = [UIColor redColor];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.mainView.mas_centerX).with.offset(-15);
        }];
    }
    return _rightImageView;
}
- (UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"discovery_banner_top1~iphone"];
        _topImageView.image = image;
        [self.mainView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView.mas_centerY);
            make.left.mas_equalTo(12);
        }];
    }
    return _topImageView;
}
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"discovery_banner_gradient~iphone"];
        //_bgImageView.backgroundColor = [UIColor purpleColor];
        [self.mainView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth / 2.0);
            make.top.bottom.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mainView);
            make.centerX.mas_equalTo(self.mainView).with.offset(40);
        }];
        [_bgImageView.superview layoutIfNeeded];
    }
    return _bgImageView;
}
- (UIImageView *)thumbImageView
{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.layer.cornerRadius = 25 * 0.5;
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.backgroundColor = [UIColor redColor];
        [self.topImageView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.right.mas_equalTo(self.topImageView.mas_centerX).with.offset(-20);
            make.centerY.mas_equalTo(self.topImageView.mas_bottom).with.offset(-5);
        }];
    }
    return _thumbImageView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor blackColor];
        _nameLabel.text = @"@尾灯灯";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.topImageView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(8);
            make.centerY.mas_equalTo(self.thumbImageView);
        }];
    }
    return _nameLabel;
}
@end
