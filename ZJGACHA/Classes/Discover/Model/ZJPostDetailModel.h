//
//  ZJPostDetailModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"
#import "ZJTagModel.h"
#import "ZJPictureMetadata.h"
#import "ZJAuthorModel.h"
#import "ZJRelatedPostsModel.h"
#import "ZJPostDetailPraiseAuthorModel.h"

@class ZJPostRankInfoModel;
@interface ZJPostDetailModel : ZJBaseModel

/** 帖子id */
@property (nonatomic, copy) NSString *pid;
/** 帖子类型 */
@property (nonatomic, assign) NSInteger type;
/** 创建时间 */
@property (nonatomic, assign) long createTime;
/** 时间字符串 */
@property (nonatomic, copy) NSString *createTimeString;
/** 标题 */
@property (nonatomic, copy) NSString *richText;
/** 标题TextLayout，如果有的话 */
@property (nonatomic, strong) YYTextLayout *richTextLayout;
/** 标题高度，如果有的话 */
@property (nonatomic, assign) CGFloat richTextHeight;
/** 帖子评论数量 */
@property (nonatomic, assign) NSInteger commentCount;
/** 帖子点赞数量 */
@property (nonatomic, assign) NSInteger supportCount;
/** 点赞的人合集 */
@property (nonatomic, strong) NSArray<ZJPostDetailPraiseAuthorModel *> *supportArray;
/** 订阅数量 */
@property (nonatomic, assign) NSInteger subCount;
/** 图片名称合集 */
@property (nonatomic, strong) NSArray *imagesID;
/** 图片总高度 */
@property (nonatomic, assign) CGFloat imagesHeight;
/** 作者id */
@property (nonatomic, copy) NSString *authorID;
/** 作者头像 */
@property (nonatomic, copy) NSString *authorAvatar;
/** 头像路径 */
@property (nonatomic, copy) NSString *avatarFullUrl;
/** 作者名称 */
@property (nonatomic, copy) NSString *authorNickName;
/** 是否订阅 */
@property (nonatomic, assign) BOOL subscribed;
/** 圈子id */
@property (nonatomic, copy) NSString *circleID;
/** 圈子名称 */
@property (nonatomic, copy) NSString *circleName;
/** 是否点赞 */
@property (nonatomic, assign) BOOL isSupport;
/** 是否收藏 */
@property (nonatomic, assign) BOOL isCollect;
/** 版权所有 */
@property (nonatomic, assign) BOOL copyrighted;
/** 是否被报道 */
@property (nonatomic, assign) BOOL isReported;
/** 标签 */
@property (nonatomic, strong) NSMutableArray<ZJTagModel *> *tags;
/** 是否删除 */
@property (nonatomic, assign) BOOL deleted;
/** 是否屏蔽 */
@property (nonatomic, assign) BOOL shield;
/** 是否喜欢这个动态 */
@property (nonatomic, assign) BOOL favoriteDynamic;
/** 显示大图集合 */
@property (nonatomic, strong) NSMutableArray<ZJPictureMetadata *> *downloadImgInfos;
/** 排行榜信息 */
@property (nonatomic, strong) ZJPostRankInfoModel *rankInfo;
/** 猜你喜欢帖子集合 */
@property (nonatomic, strong) NSMutableArray<ZJRelatedPostsModel *> *relatedPosts;

@end


@interface ZJPostRankInfoModel : ZJBaseModel

/** 排名 */
@property (nonatomic, assign) NSInteger mc;
/** 上榜日期 */
@property (nonatomic, copy) NSString *mark;
/** 榜类型 */
@property (nonatomic, assign) NSInteger *type;

@end
