//
//  Macros.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//屏幕宽、高比例系数
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width / 375.0
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height / 667.0

#define pageMenuH 40
#define NaviH (kScreenHeight == 812 ? 88 : 64) // 812是iPhoneX的高度

#define placeholderFailImage [YYImage imageWithColor:[ZJColor colorWithHexString:@"#ECECEC"]]
//default_avatar
#define placeholderAvatarImage [UIImage imageNamed:@"default_avatar"]
#define backArrowIcon          [UIImage imageNamed:@"navigation_back"]
#define backArrowWhiteIcon     [UIImage imageNamed:@"navigation_back_white"]

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define KStatusBarHeight (kDevice_Is_iPhoneX ? 24.f:0.f)
#define KStatusBarMargin (kDevice_Is_iPhoneX ? 22.f:0.f)
#define KTabBarHeight    (kDevice_Is_iPhoneX ? 34.f:0.f)

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

//自定义输出日志
#define XBDLog(...) NSLog(@"%s\n %@\n\n",__func__,[NSString stringWithFormat:__VA_ARGS__])

//真机打印日志
#ifdef DEBUG
#define NSLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif





#endif /* Macros_h */
