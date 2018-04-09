//
//  ZJBaseModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"

@implementation ZJBaseModel

- (NSString *)dispose:(id)data{
    if (data == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",data];
}

- (NSArray *)arrDispose:(id)data{
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return [NSArray array];
}

- (NSDictionary *)dicDispose:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    return [NSDictionary dictionary];
}

@end
