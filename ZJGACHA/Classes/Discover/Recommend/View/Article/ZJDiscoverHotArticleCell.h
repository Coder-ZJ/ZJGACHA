//
//  ZJDiscoverHotArticleCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseTabelViewCell.h"
#import "ZJDiscoverHotArticleCellLayout.h"
#import "ZJDiscoverHotArticleTagsView.h"
#import "ZJDiscoverHotArticleProfileView.h"

@interface ZJDiscoverHotArticleCell : ZJBaseTabelViewCell

/** 主容器 */
@property (nonatomic, strong) UIView        *mainView;
/** 文章配图 */
@property (nonatomic, strong) UIImageView   *thumbImage;
/** 文章标题 */
@property (nonatomic, strong) YYLabel       *titleLabel;
/** 文章浏览次数 */
@property (nonatomic, strong) YYLabel       *visitLabel;
/** 文章连载字数 */
@property (nonatomic, strong) YYLabel       *wordNumLabel;
/** 文章正文 */
@property (nonatomic, strong) YYLabel       *contentLabel;
/** 阅读更多 */
@property (nonatomic, strong) UIButton      *moreButton;
/** cell布局 */
@property (nonatomic, strong) ZJDiscoverHotArticleCellLayout *layout;
/** 标签合集 */
@property (nonatomic, strong) ZJDiscoverHotArticleTagsView *tagsView;
/** 作者信息及点赞 */
@property (nonatomic, strong) ZJDiscoverHotArticleProfileView *profileView;

@end
