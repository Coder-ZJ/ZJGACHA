//
//  ZJPictureMetadata.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"

@interface ZJPictureMetadata : ZJBaseModel

@property (nonatomic, copy) NSString            *imageId;
/** 宽屏正方形图 */
@property (nonatomic, copy) NSString            *fullUrl;
@property (nonatomic, assign) CGFloat            width;
/* 实际宽度 * 2px */
@property (nonatomic, assign) CGFloat            realWidth;
@property (nonatomic, assign) CGFloat            height;
/* 实际高度 * 2px */
@property (nonatomic, assign) CGFloat            realHeight;
@property (nonatomic, assign) CGFloat            size;

@end
