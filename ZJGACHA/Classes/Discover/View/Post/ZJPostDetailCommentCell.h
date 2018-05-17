//
//  ZJPostDetailCommentCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/17.
//  Copyright © 2018年 尾灯. All rights reserved.
//  评论cell

#import "ZJBaseTabelViewCell.h"
#import "ZJPostDetailCommentModel.h"

@class ZJPostDetailCommentUserView,ZJPostDetailCommentContentView;
@interface ZJPostDetailCommentCell : ZJBaseTabelViewCell

@property (nonatomic, strong) ZJPostDetailCommentUserView *commentUserView;
@property (nonatomic, strong) ZJPostDetailCommentContentView *commentContentView;

@property (nonatomic, strong) ZJPostDetailCommentModel *commentModel;

@end


//用户信息view
@interface ZJPostDetailCommentUserView : UIView

/** 头像 */
@property (nonatomic, strong) UIImageView *avatarImageView;
/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 评论日期 */
@property (nonatomic, strong) UILabel *dateLabel;
/** 评论内容 */
@property (nonatomic, strong) YYLabel *commentLabel;
/** 喜欢按钮 */
@property (nonatomic, strong) UIButton *likeButton;
/** 喜欢人数 */
@property (nonatomic, strong) UILabel *likeCountLabel;
/** 分割线 */
@property (nonatomic, strong) UIView *topLine;

@end

//评论内容view
@interface ZJPostDetailCommentContentView : UIView

/** 评论内容 */
@property (nonatomic, strong) YYLabel *contentLabel;

@end

