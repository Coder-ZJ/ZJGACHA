//
//  ZJDiscoverRankListModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"
#import "ZJAuthorModel.h"
#import "ZJPictureMetadata.h"

@class ZJDiscoverRankingMarksModel,ZJDiscoverRankingModel;
@interface ZJDiscoverRankListModel : ZJBaseModel

/** 是否可以加载更多 */
@property (nonatomic, assign) BOOL          hasMore;
/** 排行版类型 日周月榜 */
@property (nonatomic, assign) trendType     type;
/** 当前标记日期 */
@property (nonatomic, copy) NSString        *currentMarkShow;
/** 排行榜日期model集合 */
@property (nonatomic, strong) NSArray<ZJDiscoverRankingMarksModel *>    *rankingMarks;
/** 排行榜日期字符串集合 */
@property (nonatomic, strong) NSMutableArray                   *rankingArray;
/** 帖子集合包括前三 */
@property (nonatomic, strong) NSMutableArray<ZJDiscoverRankingModel *> *rankings;
/** 去除前三的帖子集合 */
@property (nonatomic, strong) NSMutableArray                   *rankOvers;

@end

@interface ZJDiscoverRankingMarksModel:ZJBaseModel

/** 格式化日期 2017-12-13 */
@property (nonatomic, copy) NSString        *mark;
/** 格式化日期 2017年12月13日 */
@property (nonatomic, copy) NSString        *markShow;

@end

@interface ZJDiscoverRankingModel:ZJBaseModel

/** 帖子ID */
@property (nonatomic, copy) NSString        *pid;
/** 图片信息 */
@property (nonatomic, strong) ZJPictureMetadata *imageInfo;
/** 图片ID */
@property (nonatomic, copy) NSString        *imgId;
/** 图片数量 */
@property (nonatomic, assign) int           imgCount;
/** 浏览次数 */
@property (nonatomic, assign) UInt64        visiteNum;
/** 点赞 */
@property (nonatomic, assign) UInt64        likeNum;
/** 排名状态 */
@property (nonatomic, assign) NSInteger        rankState;
@property (nonatomic, assign) NSInteger        changeNum;
@property (nonatomic, assign) NSInteger        rankNum;
/** 作者信息 */
@property (nonatomic, strong) ZJAuthorModel *author;
/** 状态 */
@property (nonatomic, assign) int           state;
/** 是否点赞？ */
@property (nonatomic, assign)BOOL           hasSupport;

@end
