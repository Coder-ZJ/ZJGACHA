//
//  ZJColor.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//  颜色工具类

#import <Foundation/Foundation.h>

@interface ZJColor : NSObject

/** RGB颜色 */
+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue withAlpha:(CGFloat)alpha;

/** 十六进制 */
+ (UIColor *)colorWithHexString:(NSString *)color withAlpha:(CGFloat)alpha;

/** 十六进制 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/** 透明色 */
+ (UIColor *)clearColor;

/** 白色 */
+ (UIColor *)whiteColor;

/** 黑色 */
+ (UIColor *)blackColor;

/** app主题颜色 */
+ (UIColor *)appMainColor;

/** 文本灰色 （导航标题颜色） */
+ (UIColor *)appNavTitleGrayColor;

/** 灰色间距 #f4f4f4*/
+ (UIColor *)appGraySpaceColor;

/** 文本灰色 （副标题文本颜色）#333333 */
+ (UIColor *)appSubColor;

/** 辅助颜色  #999999 */
+ (UIColor *)appSupportColor;

/** 设计师标签 #D2D2D2 */
+ (UIColor *)appLightGrayColor;

/** 辅助蓝色 #7EC1FB */
+ (UIColor *)appSubBlueColor;

/** 分割线颜色 #DCDCDC */
+ (UIColor *)appBottomLineColor;


@end
