//
//  ZJDiscoverRecommendBannerModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendBannerModel.h"

@implementation ZJDiscoverRecommendBannerModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    //文章配图
    NSString *article = dic[@"imgId"];
    if (article.length) {
        self.rightFull = [NSString stringWithFormat:@"%@%@%@",HttpImageURLPre,article,@"?imageView&enlarge=1&quality=75&thumbnail=750y490&type=webp"];
    }
    if (dic[@"headPic"]) {
        self.headFull = [NSString stringWithFormat:@"%@%@%@",HttpImageURLPre,dic[@"headPic"],@"?imageView&quality=75&thumbnail=80x80&type=webp"];
    }

    return YES;

}

@end
