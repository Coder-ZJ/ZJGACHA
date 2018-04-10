//
//  ZJDiscoverInsetModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"
#import "ZJWorksModel.h"

@class ZJDiscoverInsetPostListModel;
@interface ZJDiscoverInsetModel : ZJBaseModel

/** 推荐插画用户model */
@property (nonatomic, strong) NSMutableArray<ZJWorksModel *> *remAccounts;

/** 热门插画列表 */
@property (nonatomic, strong) ZJDiscoverInsetPostListModel *channelPost;

@end

@interface ZJDiscoverInsetPostModel : ZJBaseModel

/** 帖子ID */
@property (nonatomic, copy) NSString *postId;
/** imgId */
@property (nonatomic, copy) NSString *imgId;
/** 封面图后缀 */
@property (nonatomic, copy) NSString    *imageSuffix;
/** 宽度 */
@property (nonatomic, assign) CGFloat   width;
/* 实际宽度 * 2px */
@property (nonatomic, assign) CGFloat   realWidth;
/** 高度 */
@property (nonatomic, assign) CGFloat   height;
/* 实际高度 * 2px */
@property (nonatomic, assign) CGFloat   realHeight;
/** 是否点赞 */
@property (nonatomic, assign) BOOL      hasPraise;
/** 状态 */
@property (nonatomic, assign) UInt64    state;
/** 数量 */
@property (nonatomic, assign) CGFloat   imgCount;
/** 作者信息 */
@property (nonatomic, strong) ZJAuthorModel *author;
/** 类型 1是文章、2是插画、3是COS*/
@property (nonatomic, assign) UInt64    type;
/** 排序位置 */
@property (nonatomic, assign) UInt64    no;


@end

@interface ZJDiscoverInsetPostListModel : ZJBaseModel

/** 是否有下一页 */
@property (nonatomic, assign) BOOL      hasMore;
/** 记录最后一个插画帖子的ID,用来分页 */
@property (nonatomic, copy) NSString   *lastId;
/** 插画帖子集合 */
@property (nonatomic, strong) NSMutableArray<ZJDiscoverInsetPostModel *> *posts;

@end
