//
//  ZJDiscoverHeadModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//  头model

#import <Foundation/Foundation.h>

@interface ZJDiscoverHeadModel : NSObject

/** uid */
@property (nonatomic, copy) NSString    *uid;
/** 图片url */
@property (nonatomic, copy) NSString    *img;
/** 图片 */
@property (nonatomic, strong) UIImage   *icon;
/** 文字 */
@property (nonatomic, copy) NSString    *title;
/** 是否显示额外按钮 */
@property (nonatomic, assign) BOOL      show;

@end
