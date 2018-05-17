//
//  NSDate+ZJDateFormat.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZJDateFormat)


/**
 时间戳转字符串

 @param format 字符串格式
 @param timestamp 时间戳
 @return 时间字符串
 */
+ (NSString *)timestampToStringWithFormat:(NSString *)format andTimestamp:(long)timestamp;

@end

