//
//  ZJDiscoverArticleModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverArticleModel.h"

@implementation ZJDiscoverArticleModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"remNovels" : [ZJDiscoverHotArticleModel class]
             };
}


@end

@implementation ZJDiscoverArticleChannelPostModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"posts" : [ZJDiscoverHotArticleModel class]
             };
}

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

