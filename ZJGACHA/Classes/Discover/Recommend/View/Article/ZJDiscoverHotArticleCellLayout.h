//
//  ZJDiscoverHotArticleCellLayout.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//  cell布局

#import <Foundation/Foundation.h>
#import "ZJDiscoverHotArticleModel.h"

@interface ZJDiscoverHotArticleCellLayout : NSObject

/** 数据 */
@property (nonatomic, strong) ZJDiscoverHotArticleModel *hotArticleModel;
/** 顶部灰色留白 */
@property (nonatomic, assign) CGFloat       marginTop;
/** 标题的高度 */
@property (nonatomic, assign) CGFloat       titleHeight;
/** 文章标题 */
@property (nonatomic, strong) YYTextLayout *titleTextLayout;
/** 浏览次数高度 */
@property (nonatomic, assign) CGFloat       visitHeight;
/** 浏览次数 */
@property (nonatomic, strong) YYTextLayout *visitTextLayout;
/** 连载字数高度 */
@property (nonatomic, assign) CGFloat       wordNumHeight;
/** 连载字数 */
@property (nonatomic, strong) YYTextLayout *wordNumTextLayout;
/** 正文高度(包括下方留白) */
@property (nonatomic, assign) CGFloat       textHeight;
/** 正文 */
@property (nonatomic, strong) YYTextLayout *textLayout;
/** 标签高度 */
@property (nonatomic, assign) CGFloat       tagHeight;
/** 作者信息高度 */
@property (nonatomic, assign) CGFloat       profileHeight;
/** 下边留白 */
@property (nonatomic, assign) CGFloat       marginBottom;
/** 总高度 */
@property (nonatomic, assign) CGFloat       height;

//初始布局
- (instancetype)initWithStatus:(ZJDiscoverHotArticleModel *)hotArticleModle;
//计算布局
- (void)layout;

@end

/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : YYTextLinePositionSimpleModifier

/** 基准字体 (例如 Heiti SC/PingFang SC) */
@property (nonatomic, strong) UIFont *font;
/** 文本顶部留白 */
@property (nonatomic, assign) CGFloat paddingTop;
/** 文本底部留白 */
@property (nonatomic, assign) CGFloat paddingBottom;
/** 行距倍数 */
@property (nonatomic, assign) CGFloat lineHeightMultiple;

- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end

