//
//  ZJPostDetailModel.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailModel.h"
#import "ZJDiscoverHotArticleCellLayout.h"

@implementation ZJPostDetailModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"pid" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"tags" : [ZJTagModel class],
             @"downloadImgInfos" : [ZJPictureMetadata class],
             @"relatedPosts" : [ZJRelatedPostsModel class]
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    NSString *suffix = [self dispose:dic[@"authorAvatar"]];
    self.avatarFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];

    //返回时间日期格式
    if ([self dispose:dic[@"createTime"]]) {
        self.createTimeString = [NSDate timestampToStringWithFormat:@"yyyy-MM-dd" andTimestamp:[[self dispose:dic[@"createTime"]] longValue]];
    }
    //标题高度，如果有的话
    self.richTextHeight = 0;
    if ([self dispose:dic[@"richText"]].length) {
        [self layoutRichText:[self dispose:dic[@"richText"]]];
    }
    //计算图片总高度，如果有的话
    self.imagesHeight = 0;
    if (self.downloadImgInfos.count) {
        for (ZJPictureMetadata *model in self.downloadImgInfos) {
            //提前算出cell需要的高度，5是图片之间上下间距
            self.imagesHeight += model.height * kScreenWidth / model.width ;
        }
        self.imagesHeight +=  (self.downloadImgInfos.count - 1) * 5;
    }
    return YES;
}

#pragma mark - 计算标题高度
- (void)layoutRichText:(NSString *)text{
    if (!text.length) return;
    NSMutableAttributedString *wordText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    wordText.alignment = NSTextAlignmentLeft;
    wordText.color = [ZJColor blackColor];
    wordText.font = [UIFont systemFontOfSize:15];
    wordText.lineBreakMode = NSLineBreakByCharWrapping;
    wordText.lineSpacing = 8;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 12 * 2, 9999)];
    _richTextLayout = [YYTextLayout layoutWithContainer:container text:wordText];
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:15];
    modifier.paddingTop = 15;
    modifier.paddingBottom = 15;
    //这里计算某些文字会出问题，暂时没找到原因，改用下面的代码
    //_richTextHeight = [modifier heightForLineCount:_richTextLayout.rowCount];
    _richTextHeight = _richTextLayout.textBoundingSize.height + modifier.paddingTop + modifier.paddingBottom;

    NSLog(@"高度 = %.2f",_richTextHeight);
}

@end

@implementation ZJPostRankInfoModel

@end
