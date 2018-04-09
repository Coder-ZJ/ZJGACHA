//
//  ZJDiscoverHotTopicModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//  热门专题

#import "ZJBaseModel.h"

@interface ZJDiscoverHotTopicModel : ZJBaseModel

/** id */
@property (nonatomic, copy) NSString *uid;
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 封面图 */
@property (nonatomic, copy) NSString *cover;
/** 封面图后缀 */
@property (nonatomic, copy) NSString *imageSuffix;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 数量 */
@property (nonatomic, assign) UInt64 num;
/** 关注数量 */
@property (nonatomic, assign) UInt64 followCount;
/** 是否私有 */
@property (nonatomic, assign) BOOL   isPrivate;
/** 类型 */
@property (nonatomic, assign) UInt64 type;

@end
