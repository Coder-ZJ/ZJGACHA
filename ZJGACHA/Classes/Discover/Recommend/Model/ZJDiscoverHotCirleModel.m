//
//  ZJDiscoverHotCirleModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotCirleModel.h"

@implementation ZJDiscoverHotCirleModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"circlePic"];
    if (![suffix isKindOfClass:[NSString class]]) return NO;
    self.imageSuffix = [suffix componentSeparatedByString:suffix];
    return YES;
    return YES;
}
@end
