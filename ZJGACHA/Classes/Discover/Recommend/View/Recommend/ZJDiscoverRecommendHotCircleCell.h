//
//  ZJDiscoverRecommendHotCircleCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//  热门圈子

#import "ZJBaseTabelViewCell.h"
#import "ZJDiscoverHotCirleModel.h"

@interface ZJDiscoverRecommendHotCircleCell : ZJBaseTabelViewCell

- (void)setupUI:(NSArray *)array;

@end

@interface ZJDiscoverRecommendHotCircleCellView : UIView

/** 容器 */
@property (nonatomic, strong) UIView *mainView;
/** 配图 */
@property (nonatomic, strong) UIImageView *thumbImageView;
/** 名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 数量 */
@property (nonatomic, strong) UILabel *numLabel;
/** 进入按钮 */
@property (nonatomic, strong) UIButton *intoButton;

@property (nonatomic, strong) ZJDiscoverHotCirleModel *model;

@end

