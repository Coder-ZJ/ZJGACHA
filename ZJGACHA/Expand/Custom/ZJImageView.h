//
//  ZJImageView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJImageView : UIImageView

/** 加载图片的方式 不把这个图片加载到内存中 */
@property (nonatomic,assign) BOOL turnOffSetLayer;

- (void)setProgressAnimationStyle:(BOOL)isProgressLayer;

- (void)setAnimationLoadingImage:(NSURL *)url placeholder:(UIImage *)placeholder;

- (void)setBlurImageView;

@end

@interface ZJMaskImageView : UIImageView

@property (nonatomic, assign) BOOL isShowMask;
@property (nonatomic, strong) UIView  *maskView;

@end
