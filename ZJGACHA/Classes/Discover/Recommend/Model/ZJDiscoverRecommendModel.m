//
//  ZJDiscoverRecommendModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendModel.h"

@implementation ZJDiscoverRecommendModel

- (NSMutableArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc] init];;
    }
    return _bannerArray;
}
- (NSMutableArray *)hotTopicArray{
    if (!_hotTopicArray) {
        _hotTopicArray = [[NSMutableArray alloc] init];;
    }
    return _hotTopicArray;
}
- (NSMutableArray *)hotCircleArray{
    if (!_hotCircleArray) {
        _hotCircleArray = [[NSMutableArray alloc] init];;
    }
    return _hotCircleArray;
}

@end
