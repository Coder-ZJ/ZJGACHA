//
//  ZJDiscoverHotTopicModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotTopicModel.h"

@implementation ZJDiscoverHotTopicModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"uid":@"id"
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"cover"];
    if (![suffix isKindOfClass:[NSString class]]) return NO;
    self.imageSuffix = [suffix componentSeparatedByString:suffix];
    return YES;
}

@end
