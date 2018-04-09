//
//  Interface.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//  数据接口

#ifndef Interface_h
#define Interface_h


#define BaseURL                            @"https://api.gacha.163.com/api/v1"
#define BaseURLV2                          @"https://api.gacha.163.com/api/v2"

/** 图片url */
#define HttpImageURLPre                    @"https://gacha.nosdn.127.net/"
#define HttpImageURLSuffixSquare           @"?imageView&enlarge=1&quality=75&thumbnail=750y750&type="
#define HttpImageURLSuffixScanle(width,height)           @"?imageView&enlarge=1&quality=75&thumbnail="width@"y"height@"&type="

/** 发现 - 推荐 */
#define DiscoveryRecommendInfo             BaseURL@"/discovery"
/** 发现 - 热推更多 */
#define DiscoveryNextNewRecommend          BaseURL@"/discover/nextNewRecommend"
/** 发现 - 插画、文章、COS */
#define DiscoveryInsetInfo                 BaseURL@"/discovery/post"
/** 发现 - 插画、文章、COS - 下一页 */
#define DiscoveryInsetNextPopularPosts     BaseURL@"/discover/nextPopularPosts"
/** 发现 - 排行 */
#define DiscoveryRankingList               BaseURL@"/rankingList"
/** 发现 - 专题详情信息 */
#define DiscoverTopicCollectInfo           BaseURL@"/collect/info"
/** 发现 - 专题用户信息 */
#define DiscoverTopicUserInfo              BaseURL@"/user/detailInfo"
/** 发现 - 专题帖子列表 */
#define DiscoverTopicSublist               BaseURLV2@"/collect/sublist"

/** 帖子详情 */
#define PostDetailInfo                     BaseURL@"/post/V2"
/** 喜欢这个帖子相关的人 */
#define PostSupportUsersList               BaseURL@"/post/supportUsers"
/** 帖子热评 */
#define PostHotcommentsList                BaseURL@"/post/hotcomments"
/** 帖子评论分页 */
#define PostCommentsList                   BaseURL@"/post/comments"


#endif /* Interface_h */
