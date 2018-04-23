//
//  ZJDiscoverRecommendView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendView.h"
#import "ZJDiscoverRecommendBannerCell.h"
#import "ZJDiscoverRecommendHotTopicCell.h"
#import "ZJDiscoverRecommendMoreTitleCell.h"
#import "ZJDiscoverRecommendHotCircleCell.h"
#import "ZJDiscoverRecommendHotRecommendCell.h"
#import "ZJDiscoverRecommendHeadView.h"
#import "ZJDiscoverHeadModel.h"
#import "ZJDiscoverRecommendBannerModel.h"
#import "ZJDiscoverRecommendModel.h"
#import "ZJDiscoverHotTopicModel.h"
#import "ZJDiscoverHotCirleModel.h"
#import "ZJDiscoverHotRecommendModel.h"
#import "ZJDiscoverRankViewController.h"

@interface ZJDiscoverRecommendView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZJDiscoverRecommendHeadView *hotHeaderView;
@property (nonatomic, strong) ZJDiscoverRecommendHeadView *hotCircleHeaderView;
@property (nonatomic, strong) ZJDiscoverRecommendHeadView *hotRecommendHeaderView;
@property (nonatomic, strong) ZJDiscoverRecommendModel *recommendModel;
@property (nonatomic, strong) ZJDiscoverRecommendHotRecommendCell *hotRecommendCell;

@end

@implementation ZJDiscoverRecommendView
{
    NSInteger _page;
}
#pragma mark -----------------lazy-----------------
- (ZJDiscoverRecommendHeadView *)hotHeaderView
{
    if (!_hotHeaderView) {
        _hotHeaderView = [[ZJDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"热门专题";
        headModel.icon = [YYImage imageNamed:@"discovery_icon_glist~iphone"];
        _hotHeaderView.headModel = headModel;
    }
    return _hotHeaderView;
}
- (ZJDiscoverRecommendHeadView *)hotCircleHeaderView
{
    if (!_hotCircleHeaderView) {
        _hotCircleHeaderView = [[ZJDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"热门圈子";
        headModel.icon = [YYImage imageNamed:@"discovery_icon_circle~iphone"];
        _hotCircleHeaderView.headModel = headModel;
    }
    return _hotCircleHeaderView;
}
- (ZJDiscoverRecommendHeadView *)hotRecommendHeaderView
{
    if (!_hotRecommendHeaderView) {
        _hotRecommendHeaderView = [[ZJDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _hotRecommendHeaderView.isShow = YES;
        WeakSelf(self);
        _hotRecommendHeaderView.changeStyleBlock = ^(BOOL selected) {
            if (selected) {
                weakself.hotRecommendCell.style = itemStyleSingle;
                weakself.hotRecommendCell.needUpdate = YES;
                [weakself.tableView reloadData];
            }else{
                weakself.hotRecommendCell.style = itemStyleDouble;
                weakself.hotRecommendCell.needUpdate = YES;
                [weakself.tableView reloadData];
            }
        };
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"GACHA热推";
        headModel.icon  = [YYImage imageNamed:@"hot_illustration_title"];
        _hotRecommendHeaderView.headModel = headModel;
    }
    return _hotRecommendHeaderView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        _page = 1;
        [self setupUI];
    }
    return self;
}

#pragma mark -----------------设置UI-----------------
- (void)setupUI
{
    self.tableView = [[ZJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    //注册cell
    [self.tableView registerClass:[ZJDiscoverRecommendBannerCell class] forCellReuseIdentifier:@"bannerCell"];
    [self.tableView registerClass:[ZJDiscoverRecommendHotTopicCell class] forCellReuseIdentifier:@"hotTopicCell"];
    [self.tableView registerClass:[ZJDiscoverRecommendMoreTitleCell class] forCellReuseIdentifier:@"moreTitleCell"];
     [self.tableView registerClass:[ZJDiscoverRecommendHotCircleCell class] forCellReuseIdentifier:@"hotCircleCell"];
    [self.tableView registerClass:[ZJDiscoverRecommendHotRecommendCell class] forCellReuseIdentifier:@"hotRecommendCell"];

    WeakSelf(self);
    self.tableView.mj_header = [ZJRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakself getRecommendData];
    }];
    self.tableView.mj_footer = [ZJRefreshGifFooter footerWithRefreshingBlock:^{
        _page++;
        [weakself loadMoreRecommendList];
    }];
    [self getRecommendData];
}
#pragma mark -----------------UITableViewDelegate&UITableViewDataSource-----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 119 * FIT_WIDTH;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 190 * FIT_WIDTH + 2 + (kScreenWidth - 2) / 2.0;
        }else{
            return 50;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            float line = ceilf(6 * 1.0/3);
            return (18 + 5 + 15 + 8 + 30 + 8 + (kScreenWidth - 10 - 10 - 4)/3) * line + line * 2 + 2;
        }else{
            return 50;
        }
    }else if (indexPath.section == 3){
        return self.hotRecommendCell.cacheHeight;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2 || section == 3) {
        return 40;
    }
    return 0.000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.hotHeaderView;
    }else if (section == 2){
        return self.hotCircleHeaderView;
    }else if (section == 3){
        return self.hotRecommendHeaderView;
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.recommendModel.bannerArray.count) {
        ZJDiscoverRecommendBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:@"bannerCell"];
        bannerCell.bannerModel = [self.recommendModel.bannerArray safeObjectAtIndex:0];
        return bannerCell;
    }else if (indexPath.section == 1 && self.recommendModel.hotTopicArray.count) {
        if (indexPath.row == 0) {
            ZJDiscoverRecommendHotTopicCell *hotTopicCell = [tableView dequeueReusableCellWithIdentifier:@"hotTopicCell"];
            [hotTopicCell setupUI:self.recommendModel.hotTopicArray];
            return hotTopicCell;
        }
    }else if (indexPath.section == 2 && self.recommendModel.hotCircleArray.count){
        if (indexPath.row == 0) {
            ZJDiscoverRecommendHotCircleCell *hotCircleCell = [tableView dequeueReusableCellWithIdentifier:@"hotCircleCell"];
            [hotCircleCell setupUI:self.recommendModel.hotCircleArray];
            return hotCircleCell;
        }
    }else if (indexPath.section == 3 && self.recommendModel){
        ZJDiscoverRecommendHotRecommendCell *hotRecommendCell = [tableView dequeueReusableCellWithIdentifier:@"hotRecommendCell"];
        self.hotRecommendCell = hotRecommendCell;
        if (self.recommendModel.recommendListModel.data.count) {
            [hotRecommendCell setDataArray:self.recommendModel.recommendListModel.data];
        }
        __weak typeof(hotRecommendCell) weakCell = hotRecommendCell;
        WeakSelf(self);
        hotRecommendCell.updateCellHeight = ^(CGFloat height){
            weakCell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        };
        return hotRecommendCell;
    }
    if (indexPath.row == 1 && (indexPath.section == 1 || indexPath.section == 2)) {
        ZJDiscoverRecommendMoreTitleCell *moreTitleCell = [tableView dequeueReusableCellWithIdentifier:@"moreTitleCell"];
        if (indexPath.section == 1) {
            moreTitleCell.nameLabel.text = @"查看更多专题";
        }else{
            moreTitleCell.nameLabel.text = @"更多热门圈子";
        }
        return moreTitleCell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //跳转排行榜
        ZJDiscoverRankViewController *rankVC = [[ZJDiscoverRankViewController alloc] init];
        [self.viewController.navigationController pushViewController:rankVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        //查看更多专题
        NSLog(@"查看更多专题");
    }else if (indexPath.section == 2 && indexPath.row == 1){
        //更多热门圈子
        NSLog(@"更多热门圈子");
    }
}

#pragma mark -----------------网络请求-----------------
- (void)getRecommendData
{
    //NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [ZJLoadingView showLoadingInView:self];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryRecommendInfo withParameters:nil withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual: @200]) {
            ZJDiscoverRecommendModel *model = [[ZJDiscoverRecommendModel alloc] init];
            NSArray *discoverInfos = responseObject[@"result"][@"discoverInfos"];
            for (NSDictionary *dic in discoverInfos) {
                NSString *type = dic[@"itemType"];
                //banner 日榜
                if ([type isEqualToString:@"banner"]) {
                    id str = dic[@"data"];
                    id dataArray = [str toArrayOrNSDictionary];
                    for (NSDictionary *banner in dataArray) {
                        ZJDiscoverRecommendBannerModel *bannerModel = [ZJDiscoverRecommendBannerModel modelWithJSON:banner];
                        [model.bannerArray addObject:bannerModel];
                    }
                }

                //热门专题
                if ([type isEqualToString:@"hotGList"]) {
                    id str = dic[@"data"];
                    id dataArray = [str toArrayOrNSDictionary];
                    for (NSDictionary *topic in dataArray) {
                        ZJDiscoverHotTopicModel *hotTopicModel = [ZJDiscoverHotTopicModel modelWithJSON:topic];
                        [model.hotTopicArray addObject:hotTopicModel];
                    }
                }

                //热门圈子
                if ([type isEqualToString:@"hotCircle"]) {
                    id str = dic[@"data"];
                    id dataArray = [str toArrayOrNSDictionary];
                    for (NSDictionary *circle in dataArray[@"list"]) {
                        ZJDiscoverHotCirleModel *hotCircleModel = [ZJDiscoverHotCirleModel modelWithJSON:circle];
                        [model.hotCircleArray addObject:hotCircleModel];
                    }
                }

                //GACHA热推
                if ([type isEqualToString:@"recommendList"]) {
                    id str = dic[@"data"];
                    id dataArray = [str toArrayOrNSDictionary];
                    ZJHotRecommendListModel *hotRecommendListModel = [ZJHotRecommendListModel modelWithJSON:dataArray];
                    model.recommendListModel = hotRecommendListModel;
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideAllLoadingForView:weakself];
                weakself.recommendModel = model;
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer resetNoMoreData];
                [weakself.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideAllLoadingForView:weakself];
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer resetNoMoreData];
                [weakself.tableView reloadData];
            });
        }

    } withFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJLoadingView hideAllLoadingForView:weakself];
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer resetNoMoreData];
            if (!_recommendModel) {
                [ZJLoadFailedView showLoadFailedInView:weakself topEdge:0 retryHandle:^{
                    [weakself getRecommendData];
                }];
            }
        });
    }];
}

//加载更多数据
- (void)loadMoreRecommendList{
    if (!self.recommendModel.recommendListModel.hasMore || _page > 3) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"endCosId"] = self.recommendModel.recommendListModel.endCosId;
    param[@"endPicId"] = self.recommendModel.recommendListModel.endPicId;
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryNextNewRecommend withParameters:param withSuccess:^(id responseObject) {
        if ( [responseObject[@"result"][@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = responseObject[@"result"][@"data"];
            for (NSDictionary *dic in data) {
                ZJDiscoverHotRecommendModel *model = [ZJDiscoverHotRecommendModel modelWithJSON:dic];
                [weakself.recommendModel.recommendListModel.data addObject:model];
            }
            weakself.recommendModel.recommendListModel.hasMore = [responseObject[@"result"][@"hasMore"] boolValue];
            weakself.recommendModel.recommendListModel.endPicId = responseObject[@"result"][@"endPicId"];
            weakself.recommendModel.recommendListModel.endCosId = responseObject[@"result"][@"endCosId"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView.mj_footer endRefreshing];
                weakself.hotRecommendCell.needUpdate = YES;
                [weakself.tableView reloadData];
            });
        }
    } withFailure:^(NSError *error) {
        [weakself.tableView.mj_footer endRefreshing];
    }];
}

@end
