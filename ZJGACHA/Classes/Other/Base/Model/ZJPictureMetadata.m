//
//  ZJPictureMetadata.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPictureMetadata.h"

@implementation ZJPictureMetadata


- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"imageId"]];
    if (suffix.length) {
        self.fullUrl = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=750y750&type=webp",HttpImageURLPre,suffix];
    }

    if (self.width && self.height) {
        //实际宽度
        self.realWidth = (kScreenWidth - 2)/1.0;

        //长图（392,463）、正方形图（比例接近1，296,350）、短图（294,347）
        //首先判断是否长图
        if (self.height / self.width > 1.5) {
            self.realHeight = 463 * FIT_WIDTH;
        }else if(self.height / self.width < 1){
            self.realHeight = 347 * FIT_WIDTH;
        }else if (self.height / self.width >= 1){
            self.realHeight = 350 * FIT_WIDTH;
        }else{
            self.realHeight = self.realWidth;
        }
    }
    return YES;
}

@end
