//
//  ZJPostDetailCommentModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/17.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"

@interface ZJPostDetailCommentModel : ZJBaseModel

/** ID */
@property (nonatomic, copy) NSString *cid;
/** postID */
@property (nonatomic, copy) NSString *postID;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 用户ID */
@property (nonatomic, copy) NSString *userID;
/** 用户昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 用户头像id */
@property (nonatomic, copy) NSString *avatarID;
/** 用户头像路径 */
@property (nonatomic, copy) NSString *avatarFullUrl;
/** 喜欢人数 */
@property (nonatomic, assign) NSInteger likeCount;
/** 是否喜欢 */
@property (nonatomic, assign) BOOL hasLiked;
/** 评论时间 */
@property (nonatomic, assign) long createTime;
/** 评论时间字符串 */
@property (nonatomic, copy) NSString *createTimeString;
/** 被回复的人昵称 */
@property (nonatomic, copy) NSString *atnickname;

@property (nonatomic, strong) YYTextLayout *contentLayout;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat height;

@end
