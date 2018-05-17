//
//  ZJRelatedPostsModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJRelatedPostsModel.h"

@implementation ZJRelatedPostsModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    //帖子封面图
    ZJPictureMetadata *picture = [ZJPictureMetadata modelWithJSON:dic];
    picture.imageId = [self dispose:dic[@"imgId"]];
    picture.fullUrl = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=304y405&type=webp",HttpImageURLPre,picture.imageId];
    picture.realWidth = 304 * 0.5;
    picture.realHeight = 405 * 0.5;
    self.cover = picture;

    return YES;
}


@end
