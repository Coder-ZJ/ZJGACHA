//
//  ZJLoadFailedView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//  加载失败时view

#import <UIKit/UIKit.h>

@interface ZJLoadFailedView : UIView

@property (nonatomic, strong) UIImageView    *failedImage;
@property (nonatomic, strong) UIButton       *refreshButton;

@property (nonatomic, assign) UIEdgeInsets edgeInset;

@property (nonatomic, copy) void (^retryHandle)(void);

+ (void)showLoadFailedInView:(UIView *)view;

+ (void)showLoadFailedInView:(UIView *)view retryHandle: (void (^)(void))retryHandle;

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;
+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset retryHandle: (void (^)(void))retryHandle;

+ (void)hideLoadFailedForView:(UIView *)view;

+ (ZJLoadFailedView *)loadFailedForView:(UIView *)view;

+ (void)showLoadFailedInView:(UIView *)view topEdge:(CGFloat)topEdge retryHandle: (void (^)(void))retryHandle;

- (void)showInView:(UIView *)view;

- (void)hide;

@end
