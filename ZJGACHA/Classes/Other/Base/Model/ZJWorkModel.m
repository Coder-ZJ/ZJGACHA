//
//  ZJWorkModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJWorkModel.h"

@implementation ZJWorkModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"imgId"];
    self.fullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"375", @"500")];
    return YES;
}

@end
