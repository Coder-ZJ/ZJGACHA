//
//  ZJBaseModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,itemStyle){
    itemStyleDouble = 0,    //两列
    itemStyleSingle         //单列
};

typedef NS_ENUM(NSInteger,pageViewType){
    pageViewTypeInset = 0,  //插画
    pageViewTypeCos         //COS
};

typedef NS_ENUM(NSInteger,trendType){
    trendTypeDay = 0,       //日榜
    trendTypeWeek,          //周榜
    trendTypeMonth          //月榜
};

typedef NS_ENUM(NSInteger,subjectSate){
    subjectSateNormal = 0,   //默认帖子是显示状态
    subjectSateDelete        //帖子已被删除
};

typedef NS_ENUM(NSInteger,subjectType){
    subjectTypeNormal = 0,   //默认帖子是图片类型
    subjectTypeArticle       //文章
};

@interface ZJBaseModel : NSObject

- (NSString *)dispose:(id)data;
- (NSArray *)arrDispose:(id)data;
- (NSDictionary *)dicDispose:(id)data;

@end
