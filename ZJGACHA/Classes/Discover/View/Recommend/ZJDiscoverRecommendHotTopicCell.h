//
//  ZJDiscoverRecommendHotTopicCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//  热门专题

#import "ZJBaseTabelViewCell.h"

@class ZJDiscoverRecommendHotTopicCellView;
@interface ZJDiscoverRecommendHotTopicCell : ZJBaseTabelViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) ZJDiscoverRecommendHotTopicCellView *bigImageView;
@property (nonatomic, strong) ZJDiscoverRecommendHotTopicCellView *leftImageView;
@property (nonatomic, strong) ZJDiscoverRecommendHotTopicCellView *rightImageView;

- (void)setupUI:(NSArray *)hotTopicArray;

@end


@interface ZJDiscoverRecommendHotTopicCellView : UIView

/** 容器 */
@property (nonatomic, strong) UIView        *mainView;
/** 蒙层 */
@property (nonatomic, strong) UIView        *maskView;
/** 展示图 */
@property (nonatomic, strong) ZJImageView   *bgImageView;
/** 帖子数量背景图 */
@property (nonatomic, strong) UIImageView   *numImageView;
/** 帖子数量 */
@property (nonatomic, strong) UILabel       *numLabel;
/** 月 */
@property (nonatomic, strong) UILabel       *monthLabel;
/** 日 */
@property (nonatomic, strong) UILabel       *dayLabel;
/** 名子 */
@property (nonatomic, strong) UILabel       *nameLabel;
/** 描述 */
@property (nonatomic, strong) UILabel       *descLabel;
/** 点击回调block */
@property (nonatomic, copy) void (^ clickBlock)(void);


//设置圆角
- (void)setupCornerRadiusWithDay;

@end
