//
//  ZJPostDetailPraiseAuthorModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailPraiseAuthorModel.h"

@implementation ZJPostDetailPraiseAuthorModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"avatarId"]];
    self.avatarFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];
    return YES;
}

@end
