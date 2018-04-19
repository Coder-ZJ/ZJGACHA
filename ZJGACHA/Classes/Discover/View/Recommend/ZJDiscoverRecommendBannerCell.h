//
//  ZJDiscoverRecommendBannerCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//  日榜

#import "ZJBaseTabelViewCell.h"
#import "ZJDiscoverRecommendBannerModel.h"

@class ZJDiscoverRecommendBannerCellView;
@interface ZJDiscoverRecommendBannerCell : ZJBaseTabelViewCell

@property (nonatomic, strong) ZJDiscoverRecommendBannerCellView *view;

@property (nonatomic, strong) ZJDiscoverRecommendBannerModel *bannerModel;

@end

@interface ZJDiscoverRecommendBannerCellView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UIImageView   *leftImageView;
@property (nonatomic, strong) UIImageView   *rightImageView;
@property (nonatomic, strong) UIImageView   *topImageView;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nameLabel;

@end
