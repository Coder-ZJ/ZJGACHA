//
//  NSDate+ZJDateFormat.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "NSDate+ZJDateFormat.h"

@implementation NSDate (ZJDateFormat)

+ (NSString *)timestampToStringWithFormat:(NSString *)format andTimestamp:(long)timestamp
{
    NSString * timeStampString = [NSString stringWithFormat:@"%li", (long)timestamp];

    NSTimeInterval _interval = [timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:format];
    NSString *dateSrt = [objDateformat stringFromDate: date];

    return dateSrt;
}

@end
