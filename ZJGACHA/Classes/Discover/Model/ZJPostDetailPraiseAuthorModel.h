//
//  ZJPostDetailPraiseAuthorModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"

@interface ZJPostDetailPraiseAuthorModel : ZJBaseModel

/** uid */
@property (nonatomic, copy) NSString        *uid;
/** 作者名 */
@property (nonatomic, copy) NSString        *name;
/** 头像id */
@property (nonatomic, copy) NSString        *avatarId;
/** 头像路径 */
@property (nonatomic, copy) NSString        *avatarFullUrl;

@end
