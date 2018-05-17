//
//  ZJRelatedPostsModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"
#import "ZJAuthorModel.h"
#import "ZJPictureMetadata.h"

@interface ZJRelatedPostsModel : ZJBaseModel

/** 帖子Id */
@property (nonatomic, copy) NSString *postId;
/** 帖子标题 */
@property (nonatomic, copy) NSString *title;
/** 简介 */
@property (nonatomic, copy) NSString *summary;
/** 图片数量 */
@property (nonatomic, assign) NSInteger imgCount;
/** 类型 */
@property (nonatomic, assign) NSInteger type;
/** 状态 */
@property (nonatomic, assign) NSInteger state;
/** 是否点赞 */
@property (nonatomic, assign) BOOL hasPraise;
/** 位置 */
@property (nonatomic, assign) NSInteger top;
/** 作者信息 */
@property (nonatomic, strong) ZJAuthorModel *author;
/** 帖子封面图信息 */
@property (nonatomic, strong) ZJPictureMetadata *cover;

@end
