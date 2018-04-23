//
//  ZJDiscoverRankListModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRankListModel.h"

@implementation ZJDiscoverRankListModel

- (NSMutableArray *)rankingArray{
    if (!_rankingArray) {
        _rankingArray = [NSMutableArray new];
    }
    return _rankingArray;
}
- (NSMutableArray *)rankOvers{
    if (!_rankOvers) {
        _rankOvers = [NSMutableArray new];
    }
    return _rankOvers;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"rankingMarks" : [ZJDiscoverRankingMarksModel class],
             @"rankings"     : [ZJDiscoverRankingModel class]
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSInteger currenType = [dic[@"type"] integerValue];
    if (currenType == 1) {
        self.type = trendTypeWeek;
    }else if (currenType == 2){
        self.type = trendTypeMonth;
    }else{
        self.type = trendTypeDay;
    }
    //排行榜日期集合
    for (NSDictionary *rankDic in [self arrDispose:dic[@"rankingMarks"]]) {
        [self.rankingArray addObject:[self dispose:rankDic[@"markShow"]]];
    }

    return YES;
}


@end

@implementation ZJDiscoverRankingMarksModel

@end

@implementation ZJDiscoverRankingModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"pid":@"id"
             };
}

@end
