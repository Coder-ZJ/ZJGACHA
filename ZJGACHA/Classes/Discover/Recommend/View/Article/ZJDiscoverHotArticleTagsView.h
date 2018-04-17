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

- (void)setupUI:(NSArray *)tags;

@end
