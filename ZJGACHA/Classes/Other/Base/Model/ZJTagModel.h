//
//  ZJTagModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//  标签

#import "ZJBaseModel.h"

@interface ZJTagModel : ZJBaseModel

@property (nonatomic, copy) NSString     *tagName;
@property (nonatomic, copy) NSString     *tagID;
/** 此属性作为文章第一个标签的背景图片url */
@property (nonatomic, copy) NSString     *thumb;

@end
