//
//  ZJDiscoverHotArticleProfileView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//  作者信息及点赞

#import <UIKit/UIKit.h>

@interface ZJDiscoverHotArticleProfileView : UIView

/** 容器 */
@property (nonatomic, strong) UIView            *mainView;
/** 头像 */
@property (nonatomic, strong) UIImageView       *thumb;
/** 昵称 */
@property (nonatomic, strong) YYLabel           *nickLabel;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton          *praiseButton;

@property (nonatomic, copy) void(^praiseBlock)(BOOL hasPraise);


@end
