//
//  ZJNavigationView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//  自定义导航栏

#import <UIKit/UIKit.h>

@interface ZJNavigationView : UIView

/** 背景 */
@property (nonatomic, strong) UIView    *mainView;
/** 左边按钮 */
@property (nonatomic, strong) UIButton  *leftButton;
/** 左边第二个按钮 */
@property (nonatomic, strong) UIButton  *leftTwoButton;
/** 右边按钮 */
@property (nonatomic, strong) UIButton  *rightButton;
/** 中间按钮 */
@property (nonatomic, strong) UIButton  *centerButton;
/** 右边标签 */
@property (nonatomic, strong) UILabel   *rightLabel;
/** 是否显示底部分割线 */
@property (nonatomic, assign) BOOL      showBottomLine;
/** 中间按钮文字 */
@property (nonatomic, strong) YYLabel   *centerLabel;
/** 搜索框 */
@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, copy) void (^leftButtonBlock)(void);
@property (nonatomic, copy) void (^centerButtonBlock)(void);
@property (nonatomic, copy) void (^rightButtonBlock)(void);

@end
