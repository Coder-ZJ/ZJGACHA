//
//  ZJDiscoverRecommendModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDiscoverHotRecommendModel.h"

@interface ZJDiscoverRecommendModel : ZJBaseModel

/** 轮播 */
@property (nonatomic, strong) NSMutableArray *bannerArray;
/** 热门专题 */
@property (nonatomic, strong) NSMutableArray *hotTopicArray;
/** 热门圈子 */
@property (nonatomic, strong) NSMutableArray *hotCircleArray;
/** 热推ListModel */
@property (nonatomic, strong) ZJHotRecommendListModel *recommendListModel;

@end
