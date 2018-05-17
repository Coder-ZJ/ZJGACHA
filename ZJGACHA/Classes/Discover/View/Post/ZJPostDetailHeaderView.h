//
//  ZJPostDetailHeaderView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//  头部视图  -猜你喜欢  -热门评论  -全部评论

#import <UIKit/UIKit.h>
#import "ZJDiscoverHeadModel.h"

@interface ZJPostDetailHeaderView : UIView

@property (nonatomic, strong) ZJDiscoverHeadModel *headModel;

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 图标 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 分割线 */
@property (nonatomic, strong) UIView *bottomLine;

@end
