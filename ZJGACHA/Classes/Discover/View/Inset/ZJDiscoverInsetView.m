//
//  ZJDiscoverInsetView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverInsetView.h"
#import "ZJDiscoverHeadModel.h"
#import "ZJDiscoverRecommendHeadView.h"
#import "ZJDiscoverInsetBannerCell.h"
#import "ZJDiscoverInsetHeadViewCell.h"
#import "ZJDiscoverHotInsetCell.h"

#import "ZJDiscoverInsetModel.h"

@interface ZJDiscoverInsetView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZJBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *headerArray;
@property (nonatomic, strong) ZJDiscoverRecommendHeadView *hotInsetheadView;
@property (nonatomic, strong) ZJDiscoverRecommendHeadView *hotCOSheadView;
@property (nonatomic, strong) ZJDiscoverInsetModel *insetModel;
@property (nonatomic, strong) ZJDiscoverHotInsetCell *hotInsetCell;

@end

@implementation ZJDiscoverInsetView
{
    CGFloat _page;
    CGFloat _pageCount;
    CGFloat _type;
}
#pragma mark -----------------lazy-----------------

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[ZJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [ZJColor appGraySpaceColor];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (NSMutableArray *)headerArray
{
    if (!_headerArray) {
        _headerArray = [[NSMutableArray alloc] init];
    }
    return _headerArray;
}

- (ZJDiscoverRecommendHeadView *)hotInsetheadView
{
    if (!_hotInsetheadView) {
        _hotInsetheadView = [[ZJDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _hotInsetheadView.isShow = YES;
        WeakSelf(self);
        _hotInsetheadView.changeStyleBlock = ^(BOOL selected) {
            if (selected) {
                weakself.hotInsetCell.style = itemStyleSingle;
                weakself.hotInsetCell.needUpdate = YES;
                [weakself.tableView reloadData];
            }else{
                weakself.hotInsetCell.style = itemStyleDouble;
                weakself.hotInsetCell.needUpdate = YES;
                [weakself.tableView reloadData];
            }
        };
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"热门插画";
        headModel.icon = [YYImage imageNamed:@"hot_illustration_title"];
        _hotInsetheadView.headModel = headModel;
    }
    return _hotInsetheadView;
}

- (ZJDiscoverRecommendHeadView *)hotCOSheadView
{
    if (!_hotCOSheadView) {
        _hotCOSheadView = [[ZJDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _hotCOSheadView.isShow = YES;
        WeakSelf(self);
        _hotCOSheadView.changeStyleBlock = ^(BOOL selected) {
            if (selected) {
                weakself.hotInsetCell.style = itemStyleSingle;
                weakself.hotInsetCell.needUpdate = YES;
                [weakself.tableView reloadData];
            }else{
                weakself.hotInsetCell.style = itemStyleDouble;
                weakself.hotInsetCell.needUpdate = YES;
                [weakself.tableView reloadData];
            }
        };
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"热门COS";
        headModel.icon = [YYImage imageNamed:@"hot_illustration_title"];
        _hotCOSheadView.headModel = headModel;
    }
    return _hotCOSheadView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        _page = 1;
        _pageCount = 20;
    }
    return self;
}

- (void)setPageType:(pageViewType)pageType
{
    _pageType = pageType;
    if (pageType == pageViewTypeInset) {
        //插画
        _type = 2;
        //添加头部model
        for (int i = 0; i < 3; i++) {
            ZJDiscoverHeadModel *model = [[ZJDiscoverHeadModel alloc] init];
            if (i == 0) {
                model.img   = @"illustration_chart";
                model.title = @"插画榜";
            }else if (i == 1) {
                model.img   = @"illustration_hoter";
                model.title = @"人气画师";
            }else{
                model.img   = @"special_G_select";
                model.title = @"专题精选";
            }
            [self.headerArray addObject:model];
        }
    }else{
        //COS
        _type = 3 ;
        //添加头部model
        for (int i = 0; i < 2; i++) {
            ZJDiscoverHeadModel *model = [[ZJDiscoverHeadModel alloc] init];
            if (i == 0) {
                model.img   = @"hot_coser";
                model.title = @"人气Coser";
            }else{
                model.img   = @"special_G_select";
                model.title = @"专题精选";
            }
            [self.headerArray addObject:model];
        }
    }
    [self setupUI];
}
//设置UI
- (void)setupUI
{
    [self.tableView registerClass:[ZJDiscoverInsetBannerCell class] forCellReuseIdentifier:@"bannerCell"];
    [self.tableView registerClass:[ZJDiscoverInsetHeadViewCell class] forCellReuseIdentifier:@"headViewCell"];
    [self.tableView registerClass:[ZJDiscoverHotInsetCell class] forCellReuseIdentifier:@"hotInsetCell"];

    self.tableView.mj_header = [ZJRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self getInsetData];
    }];
    self.tableView.mj_footer = [ZJRefreshGifFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadMoreInsetData];
    }];
    if (!self.insetModel.channelPost.posts.count) {
        [self getInsetData];
    }
}

#pragma mark -----------------UITableViewDelegate&UITableViewDataSource-----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 340 * FIT_WIDTH;
        }else{
            return 70;
        }
    }else{
        return self.hotInsetCell.cacheHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.000001;
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        return 0.000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (_pageType == pageViewTypeInset) {
            return self.hotInsetheadView;
        }else{
            return self.hotCOSheadView;
        }
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZJDiscoverInsetBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:@"bannerCell"];
            if (self.insetModel.remAccounts.count) {
                bannerCell.dataArray = self.insetModel.remAccounts;
            }
            return bannerCell;
        }else{
            ZJDiscoverInsetHeadViewCell *headViewCell = [tableView dequeueReusableCellWithIdentifier:@"headViewCell"];
            headViewCell.dataArray = self.headerArray;
            return headViewCell;
        }
    }else{
        ZJDiscoverHotInsetCell *hotInsetCell = [tableView dequeueReusableCellWithIdentifier:@"hotInsetCell"];
        self.hotInsetCell = hotInsetCell;
        if (self.insetModel.channelPost.posts.count) {
            [hotInsetCell setDataArray:self.insetModel.channelPost.posts];
        }
        __weak typeof(hotInsetCell) weakCell = hotInsetCell;
        WeakSelf(self);
        hotInsetCell.updateCellHeight = ^(CGFloat height){
            weakCell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        };
        return hotInsetCell;
    }
}

#pragma mark -----------------网络请求-----------------
//获取插画数据
- (void)getInsetData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@(_type) forKey:@"type"];
    [ZJLoadingView showLoadingInView:self];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryInsetInfo withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual: @200]) {
            weakself.insetModel = [ZJDiscoverInsetModel modelWithJSON:responseObject[@"result"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:self];
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer resetNoMoreData];
                [weakself.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:self];
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer resetNoMoreData];
            });
        }
    } withFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJLoadingView hideLoadingForView:self];
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer resetNoMoreData];
            [ZJLoadFailedView showLoadFailedInView:self topEdge:0 retryHandle:^{
                [weakself getInsetData];
            }];
        });
    }];
}

//加载更多热门热门插画
- (void)loadMoreInsetData
{
    if (!self.insetModel.channelPost.hasMore || _page > 4) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:self.insetModel.channelPost.lastId forKey:@"lastId"];
    [parameters setValue:@(_pageCount) forKey:@"pageCount"];
    [parameters setValue:@(_type) forKey:@"type"];
    [ZJLoadingView showLoadingInView:self];
    WeakSelf(self);
    NSLog(@"参数----->%@",parameters);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryInsetNextPopularPosts withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual:@(200)]) {
            NSArray *data = responseObject[@"result"][@"posts"];
            for (NSDictionary *dic in data) {
                ZJDiscoverInsetPostModel *model = [ZJDiscoverInsetPostModel modelWithJSON:dic];
                NSLog(@"作者名----->%@",model.author.nickName);
                [self.insetModel.channelPost.posts addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:self];
                [weakself.tableView.mj_footer endRefreshing];
                weakself.hotInsetCell.needUpdate = YES;
                [weakself.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:self];
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer resetNoMoreData];
            });
        }
    } withFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJLoadingView hideLoadingForView:self];
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer resetNoMoreData];
            [ZJLoadFailedView showLoadFailedInView:self topEdge:0 retryHandle:^{
                [weakself getInsetData];
            }];
        });
    }];
}
@end
