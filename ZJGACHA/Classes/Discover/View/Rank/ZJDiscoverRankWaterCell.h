//
//  ZJDiscoverRankWaterCell.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJDiscoverRankWaterCell : UICollectionViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;
@property (nonatomic, assign) BOOL    needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);
@property (nonatomic, assign) itemStyle style;

@end
