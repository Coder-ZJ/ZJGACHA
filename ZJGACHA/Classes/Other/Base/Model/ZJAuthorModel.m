//
//  ZJAuthorModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJAuthorModel.h"

@implementation ZJAuthorModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"portrait"]];
    self.portraitFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];

    //排行榜昵称，网易的api命名也不规范 🤷‍♀️
    if (dic[@"nickname"]) {
        self.nickName = [self dispose:dic[@"nickname"]];
    }
    //排行榜头像
    if (dic[@"avatarID"]) {
        self.portrait = [self dispose:dic[@"avatarID"]];
        self.portraitFullUrl = [NSString stringWithFormat:@"%@%@?imageView&quality=75&thumbnail=80x80&type=webp",HttpImageURLPre,self.portrait];
    }


    return YES;
}


@end
