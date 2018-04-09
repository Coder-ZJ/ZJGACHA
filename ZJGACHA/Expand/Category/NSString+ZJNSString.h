//
//  NSString+ZJNSString.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZJNSString)

#pragma mark - 获取当前时间戳
+ (NSString *)getNowTimeTimestamp;
#pragma mark - 计算文字宽度
+ (CGFloat)getTitleWidth:(NSString *)title withFontSize:(CGFloat)size;
#pragma mark - 根据当前日期返回几月🐔日
+ (NSArray *)getNowMonthAndDay;
#pragma mark - 讲json字符串转为字典或数组
- (id)toArrayOrNSDictionary;
#pragma mark - 返回图片格式
- (NSString *)componentSeparatedByString:(NSString *)string;

@end
