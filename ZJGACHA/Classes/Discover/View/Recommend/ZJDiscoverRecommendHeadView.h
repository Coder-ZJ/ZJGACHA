//
//  ZJDiscoverRecommendHeadView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//  组头

#import <UIKit/UIKit.h>
#import "ZJDiscoverHeadModel.h"

@interface ZJDiscoverRecommendHeadView : UIView

/** 是否显示布局按钮 */
@property (nonatomic, assign) BOOL isShow;
/** 切换布局block yes为单列 */
@property (nonatomic, copy) void (^changeStyleBlock)(BOOL);
/** 组头数据模型 */
@property (nonatomic, strong) ZJDiscoverHeadModel *headModel;

@end
