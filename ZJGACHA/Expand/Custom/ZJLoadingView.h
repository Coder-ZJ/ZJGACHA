//
//  ZJLoadingView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//  加载时view

#import <UIKit/UIKit.h>

@interface ZJLoadingView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) UIEdgeInsets edgeInset;

+ (void)showLoadingInView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)hideLoadingForView:(UIView *)view;

+ (void)hideAllLoadingForView:(UIView *)view;

+ (ZJLoadingView *)loadingForView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge;

- (void)showInView:(UIView *)view;

- (void)hide;

@end
