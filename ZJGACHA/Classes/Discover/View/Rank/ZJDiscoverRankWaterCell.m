//
//  ZJDiscoverRankWaterCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/20.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRankWaterCell.h"
#import "ZMWaterFlowLayout.h"
#import "ZJDiscoverHotInsetCell.h"
#import "ZJDiscoverRankListModel.h"

@interface ZJDiscoverRankWaterCell()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZJDiscoverRankWaterCell

#pragma mark -----------------lazy-----------------

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        ZMWaterFlowLayout *flowLayout = [[ZMWaterFlowLayout alloc] init];
        WeakSelf(self);
        flowLayout.updateHeight = ^(CGFloat height){
            if (height != weakself.cacheHeight && self.updateCellHeight) {
                weakself.cacheHeight = height;
                weakself.updateCellHeight(height);
            }
        };
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [ZJColor appGraySpaceColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZJDiscoverHotInsetCellCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        flowLayout.delegate = self;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)setDataArray:(NSArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    if (self.collectionView.height != self.cacheHeight || self.needUpdate) {
        self.collectionView.height = self.cacheHeight;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            self.needUpdate = NO;
        });
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZJColor appLightGrayColor];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJDiscoverHotInsetCellCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    if (self.dataArray.count) {
        [cell setupUIWithRank:itemStyleDouble model:self.dataArray[indexPath.row]];
    }
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZJDiscoverRankingModel *rankingModel = self.dataArray[indexPath.row];
    //CGFloat height = kScreenWidth / 2.0 * rankingModel.imageInfo.height / rankingModel.imageInfo.width;
    return rankingModel.imageInfo.realHeight / 2.0;
}
- (CGFloat)columnCountInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 1;
    }
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 0;
    }
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 10;
    }
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return UIEdgeInsetsMake(0, 0, 2, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}


@end
