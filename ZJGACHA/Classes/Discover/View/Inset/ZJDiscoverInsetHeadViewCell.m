//
//  ZJDiscoverInsetHeadViewCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverInsetHeadViewCell.h"
#import "ZJDiscoverHeadModel.h"

@interface ZJDiscoverInsetHeadViewCell ()<SPPageMenuDelegate>

@end

@implementation ZJDiscoverInsetHeadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    [self.contentView addSubview:_pageMenu];
    [_pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    _pageMenu.closeTrackerFollowingMode = YES;
    _pageMenu.hideLine = YES;
    _pageMenu.unSelectedItemTitleColor = [ZJColor appSupportColor];

    //传递数组，默认选中第一个
    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
    for (id model in dataArray) {
        if ([model isKindOfClass:[ZJDiscoverHeadModel class]]) {
            [itemArr addObject:((ZJDiscoverHeadModel *)model).title];
        }
    }
    [_pageMenu setItems:itemArr selectedItemIndex:0];
    for (int i = 0; i < dataArray.count; i++) {
        id model = [dataArray safeObjectAtIndex:i];
        if ([model isKindOfClass:[ZJDiscoverHeadModel class]]) {
            ZJDiscoverHeadModel *headModel = model;
            [_pageMenu setTitle:headModel.title image:[UIImage imageNamed:headModel.img] imagePosition:SPItemImagePositionTop imageRatio:0.5 forItemIndex:i];
        }
    }
    _pageMenu.showFuntionButton = NO;
    _pageMenu.delegate = self;
    self.contentView.backgroundColor = [UIColor redColor];
}

#pragma mark -----------------SPPageMenuDelegate-----------------
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index
{
    NSLog(@"----->%ld",index);
}
@end
