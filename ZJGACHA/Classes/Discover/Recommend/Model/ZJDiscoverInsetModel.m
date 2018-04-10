//
//  ZJDiscoverInsetModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverInsetModel.h"

@implementation ZJDiscoverInsetModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"remAccounts" : [ZJWorksModel class]
             };
}

@end

@implementation ZJDiscoverInsetPostModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"imgId"];
    if (![suffix isKindOfClass:[NSString class]]) return NO;
    self.imageSuffix = [suffix componentSeparatedByString:suffix];
    if (self.width && self.height) {
        //实际宽度
        self.realWidth = (kScreenWidth - 2)/1.0;

        //长图（392,463）、正方形图（比例接近1，296,350）、短图（294,347）
        //首先判断是否长图
        if (self.height / self.width > 1.3) {
            self.realHeight = 463 * FIT_WIDTH;
        }else if(self.height / self.width < 1){
            self.realHeight = 347 * FIT_WIDTH;
        }else if (self.height / self.width > 1){
            self.realHeight = 350 * FIT_WIDTH;
        }else{
            self.realHeight = self.realWidth;
        }
    }
    return YES;
}

@end

@implementation ZJDiscoverInsetPostListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"posts" : [ZJDiscoverInsetPostModel class]
             };
}

#pragma mark - 自定义解析
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    id posts = [self arrDispose:dic[@"posts"]];
    if ([posts isKindOfClass:[NSArray class]] && [posts lastObject]) {
        id lastId = ((NSDictionary *)[posts lastObject])[@"postId"];
        if (![lastId isKindOfClass:[NSString class]]) return NO;
        self.lastId = lastId;
    }
    return YES;

}

@end
