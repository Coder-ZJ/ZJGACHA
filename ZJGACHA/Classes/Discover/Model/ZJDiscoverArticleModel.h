//
//  ZJDiscoverArticleModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"
#import "ZJDiscoverHotArticleModel.h"

@class ZJDiscoverArticleChannelPostModel;
@interface ZJDiscoverArticleModel : ZJBaseModel

/** 热门文章 */
@property (nonatomic, strong) ZJDiscoverArticleChannelPostModel *channelPost;

/** 推荐文章banner */
@property (nonatomic, strong) NSArray<ZJDiscoverHotArticleModel *> *remNovels;

@end

@interface ZJDiscoverArticleChannelPostModel : ZJBaseModel

/** 是否可以加载更多 */
@property (nonatomic, assign) BOOL hasMore;
/** 用于分页 */
@property (nonatomic, copy) NSString *lastId;
/** 文章合集 */
@property (nonatomic, strong) NSMutableArray<ZJDiscoverHotArticleModel *> *posts;

@end
