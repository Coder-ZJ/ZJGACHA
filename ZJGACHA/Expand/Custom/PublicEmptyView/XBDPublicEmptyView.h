//
//  XBDPublicEmptyView.h
//  XinBaDe
//
//  Created by 张进 on 16/9/20.
//  Copyright © 2016年 MeiShunXingFei. All rights reserved.
//
//公共空界面显示视图

#import <UIKit/UIKit.h>

@interface XBDPublicEmptyView : UIView

//显示图片
@property (nonatomic, weak) UIImageView *topTipImageView;
//第一段文字
@property (nonatomic, weak) UILabel *firstL;
//第二段文字
@property (nonatomic, weak) UILabel *secondL;

//显示字符为普通字符
- (instancetype)initWithTitle:(NSString *)title
                  secondTitle:(NSString *)secondTitle
                     iconname:(NSString *)iconname;
//显示自定义属性字符
- (instancetype)initWithAttributedTitle:(NSMutableAttributedString *)attributedTitle
                  secondAttributedTitle:(NSMutableAttributedString *)secondAttributedTitle
                               iconname:(NSString *)iconname;
//显示
- (void)showInView:(UIView *)view;


@end
