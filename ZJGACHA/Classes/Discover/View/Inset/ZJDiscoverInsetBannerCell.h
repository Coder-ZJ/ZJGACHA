//
//  ZJDiscoverInsetBannerCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//  插画banner

#import "ZJBaseTabelViewCell.h"

@interface ZJDiscoverInsetBannerCell : ZJBaseTabelViewCell

/** model集合 */
@property (nonatomic, strong) NSMutableArray *dataArray;
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

@end
