//
//  ZJDiscoverArticleBannerCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//  文章推荐banner

#import "ZJBaseTabelViewCell.h"

@interface ZJDiscoverArticleBannerCell : ZJBaseTabelViewCell

/** model 集合 */
@property (nonatomic, strong) NSArray        *dataArray;
/** 图片集合 */
@property (nonatomic, strong) NSMutableArray *imagesArray;
/** 作者头像 */
@property (nonatomic, strong) UIImageView    *thumbView;
/** 昵称 */
@property (nonatomic, strong) UILabel        *nickLabel;
/** 描述 */
@property (nonatomic, strong) UILabel        *descLabel;
/** 推荐icon */
@property (nonatomic, strong) UIImageView    *iconView;
/** 推荐名 */
@property (nonatomic, strong) UILabel        *remLabel;
/** 渐变图 */
@property (nonatomic, strong) UIImageView     *maskImageView;
/** 标题 */
@property (nonatomic, strong) UILabel         *nameLabel;
/** 标签 */
@property (nonatomic, strong) UILabel         *tagLabel;
/** 立即阅读按钮 */
@property (nonatomic, strong) UIButton        *readButton;

@end
