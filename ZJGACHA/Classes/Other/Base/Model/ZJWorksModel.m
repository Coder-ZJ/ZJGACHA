//
//  ZJWorksModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJWorksModel.h"

@implementation ZJWorksModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"work" : [ZJWorkModel class]
             };
}

@end
