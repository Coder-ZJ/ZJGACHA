//
//  ZJDiscoverRankCollectionViewCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDiscoverRecommendHotRecommendCell.h"
#import "ZJDiscoverRankListModel.h"

@class ZJDiscoverRankProfileView;
@interface ZJDiscoverRankCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ZJDiscoverRecommendHotRecommendCellView *view;
@property (nonatomic, strong) ZJDiscoverRankProfileView *profileView;
@property (nonatomic, strong) ZJDiscoverRankingModel *rankingModel;

@end

@interface ZJDiscoverRankProfileView: UIView

/** 容器 */
@property (nonatomic, strong) UIView        *mainView;
/** 作者 icon */
@property (nonatomic, strong) UIImageView   *thumbImageView;
/** 作者 */
@property (nonatomic, strong) UILabel       *nameLabel;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton      *praiseButton;
/** 关注按钮 */
@property (nonatomic, strong) UIButton      *attentionButton;
/** 点赞回调 */
@property (nonatomic, copy)      void(^praiseBlock)(BOOL);

@end

@interface ZJDiscoverRanTopTitleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIImageView       *arrowView;
@property (nonatomic, copy) void(^clickChangeDateBlock)(NSString *selectStr);

@end;
