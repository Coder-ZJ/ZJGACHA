//
//  ZJAuthorModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//  作者信息

#import "ZJBaseModel.h"

@interface ZJAuthorModel : ZJBaseModel

/** 用户id */
@property (nonatomic, copy) NSString        *uid;
/** 头像 */
@property (nonatomic, copy) NSString        *portrait;
/** 头像完整路径 */
@property (nonatomic, copy) NSString        *portraitFullUrl;
/** 昵称 */
@property (nonatomic, copy) NSString        *nickName;
/** 性别 */
@property (nonatomic, assign) int           sex;
/** 验证时间 */
@property (nonatomic, assign) UInt64        expire_time;
/** 等级 */
@property (nonatomic, assign) UInt64        level;
/** 兴趣状态 */
@property (nonatomic, assign) UInt64        interestState;
/** 简介 */
@property (nonatomic, copy) NSString        *signature;
/** 微博昵称 */
@property (nonatomic, copy) NSString        *weiboNickname;
/** 微博地址 */
@property (nonatomic, copy) NSString        *weiboUrl;
/** 关系 */
@property (nonatomic, assign) int           relationType;


@end
