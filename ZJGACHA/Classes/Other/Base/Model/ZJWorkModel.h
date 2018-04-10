//
//  ZJWorkModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"

@interface ZJWorkModel : ZJBaseModel

/** 图片url后缀 */
@property (nonatomic, copy) NSString *imgId;
/** 图片全路径 */
@property (nonatomic, copy) NSString *fullUrl;
/** 帖子id */
@property (nonatomic, copy) NSString *postId;
/** type */
@property (nonatomic, assign) UInt64  type;
/** state */
@property (nonatomic, assign) UInt64  state;
/** state */
@property (nonatomic, assign) UInt64  imgCount;

@end
