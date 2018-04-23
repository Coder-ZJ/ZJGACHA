//
//  ZJDiscoverRecommendHotRecommendCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//  GACHA热推

#import "ZJBaseTabelViewCell.h"
#import "ZMWaterFlowLayout.h"
#import "ZJDiscoverHotRecommendModel.h"

@interface ZJDiscoverRecommendHotRecommendCell : ZJBaseTabelViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;
@property (nonatomic, assign) BOOL    needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);
@property (nonatomic, assign) itemStyle style;

@end

@class ZJDiscoverRecommendHotRecommendCellView,ZJDiscoverRecommendHotRecommendCellProfileView;
@interface ZJDiscoverRecommendHotRecommendCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) ZJDiscoverRecommendHotRecommendCellView     *view;
@property (nonatomic, strong) ZJDiscoverRecommendHotRecommendCellProfileView                *profileView;
@property (nonatomic, strong) ZJDiscoverHotRecommendModel   *model;

//根据布局来确定UI
- (void)setupUIWithRecommend:(itemStyle)style model:(ZJDiscoverHotRecommendModel *)model;

@end


@interface ZJDiscoverRecommendHotRecommendCellView : UIView

/** 容器 */
@property (nonatomic, strong) UIView *mainView;
/** 封面图 */
@property (nonatomic, strong) ZJImageView *thumbImageView;
/** Top icon */
@property (nonatomic, strong) UIImageView *topImageView;
/** Top标签 */
@property (nonatomic, strong) UILabel *topLabel;
/** 底部渐变层 */
@property (nonatomic, strong) UIImageView *bottomShadow;

@end

@interface ZJDiscoverRecommendHotRecommendCellProfileView : UIView

/** 容器 */
@property (nonatomic, strong) UIView        *mainView;
/** 作者 icon */
@property (nonatomic, strong) UIImageView   *thumbImageView;
/** 作者 */
@property (nonatomic, strong) UILabel       *nameLabel;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton      *praiseButton;
/** 点赞回调 */
@property (nonatomic, copy)      void(^praiseBlock)(BOOL);

@end
