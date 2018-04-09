//
//  ZJDiscoverRecommendBannerModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDiscoverRecommendBannerModel : NSObject

/** 右边图片id */
@property (nonatomic, copy) NSString        *imgId;
/** 图片全路径 */
@property (nonatomic, copy) NSString        *rightFull;
/** 作者ID */
@property (nonatomic, copy) NSString        *authorID;
/** 作者昵称 */
@property (nonatomic, copy) NSString        *authorName;
/** 作者头像 */
@property (nonatomic, copy) NSString        *headPic;
/** 作者全路径*/
@property (nonatomic, copy) NSString        *headFull;
/** 链接类型  默认是0*/
@property (nonatomic, assign) UInt64        linkType;

@end
