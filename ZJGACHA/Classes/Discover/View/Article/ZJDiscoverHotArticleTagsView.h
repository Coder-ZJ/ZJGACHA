//
//  ZJDiscoverHotArticleTagsView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//  标签合集

#import <UIKit/UIKit.h>

@interface ZJDiscoverHotArticleTagsView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *btnArray;


/**
 设置文章标签数据

 @param tags 标签数据
 */
- (void)setupUI:(NSArray *)tags;


/**
 设置帖子详情标签

 @param tags 标签数据
 */
- (void)setupPostDetailTags:(NSArray *)tags;

@end
