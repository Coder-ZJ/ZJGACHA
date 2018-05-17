//
//  ZJDiscoverRankView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/19.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRankView.h"
#import "ZJDiscoverRankCollectionViewCell.h"
#import "ZJDiscoverRankListModel.h"
#import "ZJDiscoverRankWaterCell.h"
#import "ZMStringPickerView.h"
#import "ZJPostDetailViewController.h"

@interface ZJDiscoverRankView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZJDiscoverRankListModel *rankListModel;
@property (nonatomic, strong) ZJDiscoverRankWaterCell *rankWaterCell;

@end

@implementation ZJDiscoverRankView
{
    CGFloat   _offset;
    CGFloat   _limit;
    CGFloat   _rankType;
    NSString *_currenMark;
}
#pragma mark -----------------lazy-----------------
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [ZJColor appGraySpaceColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _limit = 10;
        _offset = 0;
        _currenMark = @"pre";
    }
    return self;
}
- (void)setType:(trendType)type

{
    if (type == trendTypeDay) {
        _rankType = 0;
    }else if (type == trendTypeWeek){
        _rankType = 1;
    }else{
        _rankType = 2;
    }
    [self setupUI];
}
- (void)setupUI
{
    [self.collectionView registerClass:[ZJDiscoverRankCollectionViewCell class] forCellWithReuseIdentifier:@"topRankCell"];
    [self.collectionView registerClass:[ZJDiscoverRankWaterCell class] forCellWithReuseIdentifier:@"rankWaterCell"];
    [self.collectionView registerClass:[ZJDiscoverRanTopTitleCollectionViewCell class] forCellWithReuseIdentifier:@"topCell"];
    self.collectionView.mj_header = [ZJRefreshGifHeader headerWithRefreshingBlock:^{
        _offset = 0;
        _limit = 10;
        [self getRankingData];
    }];
    self.collectionView.mj_footer = [ZJRefreshGifFooter footerWithRefreshingBlock:^{
        _offset += 10;
        _limit += 10;
        [self loadMoreRankingData];
    }];
    [self getRankingData];
}
#pragma mark -----------------UICollectionViewDelegate&UICollectionViewDataSource-----------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (self.rankListModel.rankings.count > 3) {
            return 3;
        }else{
            return self.rankListModel.rankings.count;
        }
    }else{
        return 1;
    }
}

//item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.rankListModel) {
        return CGSizeMake(0, 0);
    }
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 45);
    }else if (indexPath.section == 1){
        ZJDiscoverRankingModel *rankingModel = [self.rankListModel.rankings safeObjectAtIndex:indexPath.row];
        CGFloat height = kScreenWidth * rankingModel.imageInfo.height / rankingModel.imageInfo.width;
        height = height > kScreenWidth * 1.4 ? kScreenWidth * 1.4 : height;
        if (indexPath.row == 0) {
            return CGSizeMake(kScreenWidth, height + 60);
        }else{
            return CGSizeMake(kScreenWidth, height + 40);
        }
    }else{
        if (self.rankListModel.rankOvers.count > 3) {
            return CGSizeMake(kScreenWidth, self.rankWaterCell.cacheHeight ? self.rankWaterCell.height : kScreenHeight);
        }else{
            return CGSizeMake(0, 0);
        }
    }
}
//边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return UIEdgeInsetsMake(5, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }else{
        return 10;
    }
}
//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZJDiscoverRanTopTitleCollectionViewCell *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        topCell.nameLabel.text = _currenMark;
        WeakSelf(self);
        __weak typeof(topCell) weakCell = topCell;
        topCell.clickChangeDateBlock = ^(NSString *selectStr) {
            [ZMStringPickerView showStringPickerWithTitle:@"" dataSource:self.rankListModel.rankingArray defaultSelValue:selectStr isAutoSelect:NO resultBlock:^(id selectValue) {
                _currenMark = selectValue;
                weakCell.nameLabel.text = selectValue;
                _offset = 0;
                _limit = 10;
                [weakself getRankingData];
            }];
        };
        return topCell;
    }else if (indexPath.section == 1 && self.rankListModel.rankings.count) {
        ZJDiscoverRankCollectionViewCell *topRankCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topRankCell" forIndexPath:indexPath];
        topRankCell.rankingModel = [self.rankListModel.rankings safeObjectAtIndex:indexPath.row];
        return topRankCell;
    }else{
        ZJDiscoverRankWaterCell *rankWaterCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rankWaterCell" forIndexPath:indexPath];
        self.rankWaterCell = rankWaterCell;
        if (self.rankListModel.rankOvers.count > 3) {
            rankWaterCell.dataArray = self.rankListModel.rankOvers;
        }
        __weak typeof(rankWaterCell) weakCell = rankWaterCell;
        WeakSelf(self);
        rankWaterCell.updateCellHeight = ^(CGFloat height){
            weakCell.height = height;
            [weakself.collectionView reloadData];
        };
        return rankWaterCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJPostDetailViewController *postDetailVC = [[ZJPostDetailViewController alloc] init];
    ZJDiscoverRankingModel *model = self.rankListModel.rankings[indexPath.row];
    postDetailVC.postId = model.pid;
    [self.viewController.navigationController pushViewController:postDetailVC animated:YES];
}

#pragma mark -----------------网络请求-----------------
- (void)getRankingData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@(_limit) forKey:@"limit"];
    [parameters setValue:@(_offset) forKey:@"offset"];
    [parameters setValue:@(_rankType) forKey:@"type"];
    if (self.rankListModel.currentMarkShow) {
        [parameters setValue:[self getFormatDate:_currenMark] forKey:@"mark"];
    }else{
        [parameters setValue:_currenMark forKey:@"mark"];
    }
    [ZJLoadingView showLoadingInView:self];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryRankingList withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual:@(200)]) {
            weakself.rankListModel = [ZJDiscoverRankListModel modelWithJSON:responseObject[@"result"]];
            //添加不包括前三的帖子
            weakself.rankListModel.rankOvers = [NSMutableArray arrayWithArray:weakself.rankListModel.rankings];
            if (weakself.rankListModel.rankings.count > 3) {
                for (int i = 0; i < 3; i++) {
                    [weakself.rankListModel.rankOvers removeObjectAtIndex:0];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:weakself];
                _currenMark = weakself.rankListModel.currentMarkShow;
                [weakself.collectionView.mj_footer resetNoMoreData];
                [weakself.collectionView.mj_header endRefreshing];
                [weakself.collectionView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:weakself];
                [weakself.collectionView.mj_footer resetNoMoreData];
                [weakself.collectionView.mj_header endRefreshing];
            });
        }
    } withFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJLoadingView hideLoadingForView:weakself];
            [weakself.collectionView.mj_footer resetNoMoreData];
            [weakself.collectionView.mj_header endRefreshing];
            [ZJLoadFailedView showLoadFailedInView:self retryHandle:^{
                [weakself getRankingData];
            }];
        });
    }];
}

//加载更多数据
- (void)loadMoreRankingData
{
    if (!self.rankListModel.hasMore) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@(_limit) forKey:@"limit"];
    [parameters setValue:@(_offset) forKey:@"offset"];
    [parameters setValue:@(_rankType) forKey:@"type"];
    if (self.rankListModel.currentMarkShow) {
        [parameters setValue:[self getFormatDate:_currenMark] forKey:@"mark"];
    }else{
        [parameters setValue:_currenMark forKey:@"mark"];
    }
    [ZJLoadingView showLoadingInView:self];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryRankingList withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual:@(200)]) {
            for (NSDictionary *dic in responseObject[@"result"][@"rankings"]) {
                 ZJDiscoverRankingModel *rankingModel = [ZJDiscoverRankingModel modelWithJSON:dic];
                 [weakself.rankListModel.rankOvers addObject:rankingModel];
            }
            weakself.rankListModel.hasMore = [responseObject[@"result"][@"hasMore"] boolValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:weakself];
                [weakself.collectionView.mj_footer endRefreshing];
                weakself.rankWaterCell.needUpdate = YES;
                [weakself.collectionView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:weakself];
                [weakself.collectionView.mj_footer endRefreshing];
            });
        }
    } withFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJLoadingView hideLoadingForView:weakself];
            [weakself.collectionView.mj_footer endRefreshing];
            [ZJLoadFailedView showLoadFailedInView:self retryHandle:^{
                [weakself getRankingData];
            }];
        });
    }];
}

#pragma mark - 格式化日期
-(NSString *)getFormatDate:(NSString *)text{
    __block NSString *format = nil;
    if (self.rankListModel.rankingMarks.count) {
        [self.rankListModel.rankingMarks enumerateObjectsUsingBlock:^(ZJDiscoverRankingMarksModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([text isEqualToString:obj.markShow]) {
                format = obj.mark;
                *stop = YES;
            }
        }];
    }
    return format;
}
@end
