//
//  ZJDiscoverHotInsetCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/10.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseTabelViewCell.h"
#import "ZJDiscoverRecommendHotRecommendCell.h"
#import "ZJDiscoverInsetModel.h"

@interface ZJDiscoverHotInsetCell : ZJBaseTabelViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;
@property (nonatomic, assign) BOOL    needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);
@property (nonatomic, assign) itemStyle style;

@end

@interface ZJDiscoverHotInsetCellCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) ZJDiscoverRecommendHotRecommendCellView     *view;
@property (nonatomic, strong) ZJDiscoverRecommendHotRecommendCellProfileView                *profileView;
@property (nonatomic, strong) ZJDiscoverInsetPostModel   *model;

//根据布局来确定UI
- (void)setupUIWithInset:(itemStyle)style model:(ZJDiscoverInsetPostModel *)model;
- (void)setupUIWithPost:(itemStyle)style model:(id)model;

@end
