//
//  ZJPostDetailCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseTabelViewCell.h"
#import "ZJPostDetailModel.h"
#import "ZJDiscoverHotArticleTagsView.h"
#import "ZJPostDetailPraiseAuthorModel.h"

@interface ZJPostDetailCell : ZJBaseTabelViewCell


@end

//排行榜cell
@interface ZJPostDetailRankCell : ZJBaseTabelViewCell

/** 背景 */
@property (nonatomic, strong) UIImageView *bgImageView;
/** 排行榜信息 */
@property (nonatomic, strong) UILabel *rankInfoLabel;
/** 查看排行榜 */
@property (nonatomic, strong) UILabel *selectRankLabel;
/** 图标 */
@property (nonatomic, strong) UIImageView *iconImageView;

@end


//用户信息cell
@interface ZJPostDetailUserInfoCell : ZJBaseTabelViewCell

/** 作者头像 */
@property (nonatomic, strong) UIImageView *avatarImageView;
/** 作者名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 日期 */
@property (nonatomic, strong) UILabel *dateLabel;
/** 圈子名称 */
@property (nonatomic, strong) UILabel *circleNameLabel;
/** 加关注按钮 */
@property (nonatomic, strong) UIButton *addCollectButton;
/** 分割线 */
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;

@end

//正文标题内容cell
@interface ZJPostDetailTextContentCell : ZJBaseTabelViewCell

/** 显示正文 */
@property (nonatomic, strong) YYLabel *textContentLabel;

@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;

@end

//正文图片cell
@interface ZJPostDetailImageListCell : ZJBaseTabelViewCell

@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;

@end

//标签cell
@interface ZJPostDetailTagsCell : ZJBaseTabelViewCell

/** 滚动标签 */
@property (nonatomic, strong) ZJDiscoverHotArticleTagsView *tagsView;

@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;

@end

//点赞的人cell
@interface ZJPostDetailPraiseCell : ZJBaseTabelViewCell

/** 点赞人数 */
@property (nonatomic, strong) UILabel *praiseCountLabel;
/** 右边icon */
@property (nonatomic, strong) UIImageView *arrowImageView;
/** 左右图片边距 */
@property (nonatomic, assign) CGFloat marginLeft;

@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;

@end

//猜你喜欢cell
@interface ZJPostDetailRelatedCell : ZJBaseTabelViewCell

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 左边图片边距 */
@property (nonatomic, assign) CGFloat marginLeft;

@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;

@end






