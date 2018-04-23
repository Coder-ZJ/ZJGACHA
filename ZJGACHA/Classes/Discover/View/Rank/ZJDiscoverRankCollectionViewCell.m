//
//  ZJDiscoverRankCollectionViewCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRankCollectionViewCell.h"

@implementation ZJDiscoverRankCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [ZJColor appGraySpaceColor];
    }
    return self;
}

- (void)setRankingModel:(ZJDiscoverRankingModel *)rankingModel
{
    _rankingModel = rankingModel;
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,rankingModel.imageInfo.imageId,rankingModel.imageInfo.width,rankingModel.imageInfo.height];
    [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    if (self.rankingModel.imageInfo.height / self.rankingModel.imageInfo.width > 1.5) {
        //self.view.thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
        //self.view.thumbImageView.clipsToBounds = YES;
    }
    //昵称
    self.profileView.nameLabel.text = rankingModel.author.nickName;
    self.profileView.nameLabel.textColor = [ZJColor blackColor];
    [self.profileView.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSString getTitleWidth:rankingModel.author.nickName withFontSize:15]);
    }];

    //是否收藏
    if (rankingModel.hasSupport) {
        [self.profileView.praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateNormal];
    }else{
        [self.profileView.praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
    }
    //排行榜是否是第一
    if (rankingModel.rankNum == 1) {
        self.profileView.attentionButton.hidden = NO;
        self.profileView.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.profileView.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            self.profileView.thumbImageView.layer.cornerRadius = 20;
        }];
        [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-60);
        }];
        [self.profileView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
        }];
        [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:rankingModel.author.portraitFullUrl] placeholder:placeholderAvatarImage];
    }else{
        self.profileView.attentionButton.hidden = YES;
        self.profileView.nameLabel.font = [UIFont systemFontOfSize:13];
        [self.profileView.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
            make.size.mas_equalTo(CGSizeMake(image.size.width + 5, image.size.width + 5));
            self.profileView.thumbImageView.layer.cornerRadius = (image.size.width + 5) * 0.5;
        }];
        self.profileView.attentionButton.hidden = YES;
        self.profileView.thumbImageView.image = [UIImage imageNamed:@"discovery_search_user"];
        [self.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-40);
        }];
        [self.profileView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
    }
    //Top
    [self.view.topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
    }];
    [self.view.topLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSString getTitleWidth:@"Top1" withFontSize:10] + 20);
    }];
    switch (rankingModel.rankNum) {
        case 1:
            self.view.topLabel.text = @"Top1";
            self.view.topImageView.image = [UIImage imageNamed:@"double_line_one"];
            break;
        case 2:
            self.view.topLabel.text = @"Top2";
            self.view.topImageView.image = [UIImage imageNamed:@"double_line_two"];
            break;
        case 3:
            self.view.topLabel.text = @"Top3";
            self.view.topImageView.image = [UIImage imageNamed:@"double_line_three"];
            break;
        default:
            break;
    }
}

#pragma mark -----------------lazy-----------------
- (ZJDiscoverRecommendHotRecommendCellView *)view
{
    if (!_view) {
        _view = [[ZJDiscoverRecommendHotRecommendCellView alloc] init];
        [self.contentView addSubview:_view];
        [self.contentView sendSubviewToBack:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-40);
        }];
    }
    return _view;
}
- (ZJDiscoverRankProfileView *)profileView
{
    if (!_profileView) {
        _profileView = [[ZJDiscoverRankProfileView alloc] init];
        _profileView.backgroundColor = [ZJColor whiteColor];
        [self.contentView addSubview:_profileView];
        [self.contentView bringSubviewToFront:_profileView];
        [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
    }
    return _profileView;
}
@end

@implementation ZJDiscoverRankProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

//点赞
- (void)clickPraiseButton:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.praiseBlock) {
        self.praiseBlock(button.selected);
    }
}

#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView
{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
        _thumbImageView.image = image;
        _thumbImageView.layer.cornerRadius = (image.size.width + 5) * 0.5;
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.mainView);
            make.size.mas_equalTo(CGSizeMake(image.size.width + 5, image.size.height + 5));
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.width.mas_equalTo(50);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nameLabel;
}

- (UIButton *)attentionButton
{
    if (!_attentionButton) {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.userInteractionEnabled = YES;
        _attentionButton.layer.cornerRadius = 5;
        _attentionButton.layer.masksToBounds = YES;
        _attentionButton.layer.borderWidth = 0.5;
        _attentionButton.layer.borderColor = [ZJColor appMainColor].CGColor;
        [_attentionButton setTitleColor:[ZJColor appMainColor] forState:UIControlStateNormal];
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_attentionButton setTitle:@"＋关注" forState:UIControlStateNormal];
        [self.mainView addSubview:_attentionButton];
        [_attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 25));
            make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(10);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _attentionButton;
}

- (UIButton *)praiseButton
{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.userInteractionEnabled = YES;
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateSelected];
        [self.mainView addSubview:_praiseButton];
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mainView.mas_right).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mainView);
        }];
        [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseButton;
}

@end

@implementation ZJDiscoverRanTopTitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self arrowView];
    }
    return self;
}
- (void)clickNameLabel
{
    if (self.clickChangeDateBlock) {
        self.clickChangeDateBlock(self.nameLabel.text);
    }
}
#pragma mark -----------------lazy-----------------
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor appSupportColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNameLabel)];
        [_nameLabel addGestureRecognizer:tap];
    }
    return _nameLabel;
}

- (UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"topic_ground_allList_back"];
        _arrowView.image = image;
        [self.contentView addSubview:_arrowView];
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(image.size.width * 0.5, image.size.height * 0.5));
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
        }];
    }
    return _arrowView;
}
@end
