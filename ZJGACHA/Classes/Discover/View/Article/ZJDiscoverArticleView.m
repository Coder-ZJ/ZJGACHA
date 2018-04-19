//
//  ZJDiscoverArticleView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverArticleView.h"
#import "ZJDiscoverArticleBannerCell.h"
#import "ZJDiscoverInsetHeadViewCell.h"
#import "ZJDiscoverRecommendHeadView.h"
#import "ZJDiscoverHeadModel.h"
#import "ZJDiscoverArticleModel.h"
#import "ZJDiscoverHotArticleCell.h"
#import "ZJDiscoverHotArticleCellLayout.h"

@interface ZJDiscoverArticleView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZJBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *headViewArray;
@property (nonatomic, strong) ZJDiscoverRecommendHeadView *headView;
@property (nonatomic, strong) ZJDiscoverArticleModel *articleModel;
@property (nonatomic, strong) NSMutableArray *hotArticleData;

@end

@implementation ZJDiscoverArticleView
{
    NSInteger page;
    NSInteger pageCount;
}
#pragma mark -----------------lazy-----------------
- (ZJBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[ZJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (NSMutableArray *)headViewArray
{
    if (!_headViewArray) {
        _headViewArray = [[NSMutableArray alloc] init];
    }
    return _headViewArray;
}

- (NSMutableArray *)hotArticleData
{
    if (!_hotArticleData) {
        _hotArticleData = [[NSMutableArray alloc] init];
    }
    return _hotArticleData;
}
- (ZJDiscoverRecommendHeadView *)headView
{
    if (!_headView) {
        _headView = [[ZJDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"热门文章";
        headModel.icon = [YYImage imageNamed:@"hot_illustration_title"];
        _headView.headModel = headModel;
    }
    return _headView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        page = 1;
        pageCount = 20;
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    //头部item数据设置
    for (int i = 0; i < 2; i++) {
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        if (i == 0) {
            headModel.title = @"人气写手";
            headModel.img = @"discover_hotAticle_hotwriter~iphone";
        }else{
            headModel.title = @"专题精选";
            headModel.img = @"special_G_select";
        }
        [self.headViewArray addObject:headModel];
    }
    [self.tableView registerClass:[ZJDiscoverArticleBannerCell class] forCellReuseIdentifier:@"bannerCell"];
    [self.tableView registerClass:[ZJDiscoverInsetHeadViewCell class] forCellReuseIdentifier:@"insetHeadViewCell"];
    [self.tableView registerClass:[ZJDiscoverHotArticleCell class] forCellReuseIdentifier:@"hotArticleCell"];

    self.tableView.mj_header = [ZJRefreshGifHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getArticleData];
    }];
    self.tableView.mj_footer = [ZJRefreshGifFooter footerWithRefreshingBlock:^{
        page++;
        [self loadMoreData];
    }];
    [self getArticleData];
}
#pragma mark -----------------UITableViewDelegate&UITableViewDataSource-----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.hotArticleData.count + 1;
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
        ZJDiscoverHotArticleCellLayout *layout = [self.hotArticleData safeObjectAtIndex:indexPath.section - 1];
        return layout.height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.headView;
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZJDiscoverArticleBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:@"bannerCell"];
            if (self.articleModel.remNovels.count) {
                bannerCell.dataArray = self.articleModel.remNovels;
            }
            return bannerCell;
        }else{
            ZJDiscoverInsetHeadViewCell *headViewCell = [tableView dequeueReusableCellWithIdentifier:@"insetHeadViewCell"];
            if (self.headViewArray.count) {
                headViewCell.dataArray = self.headViewArray;
            }
            return headViewCell;
        }
    }else{
        ZJDiscoverHotArticleCell *hotArticleCell = [tableView dequeueReusableCellWithIdentifier:@"hotArticleCell"];
        if (self.hotArticleData.count) {
            hotArticleCell.layout = [self.hotArticleData safeObjectAtIndex:indexPath.section - 1];
        }
        return hotArticleCell;
    }
}

#pragma mark -----------------网络请求-----------------

- (void)getArticleData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@(1) forKey:@"type"];
    [ZJLoadingView showLoadingInView:self];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryInsetInfo withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual: @200]) {
            weakself.articleModel = [ZJDiscoverArticleModel modelWithJSON:responseObject[@"result"]];
            for (ZJDiscoverHotArticleModel *article in weakself.articleModel.channelPost.posts) {
                //初始化文章布局
                ZJDiscoverHotArticleCellLayout *layout = [[ZJDiscoverHotArticleCellLayout alloc] initWithStatus:article];
                [self.hotArticleData addObject:layout];
            }
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
                [weakself getArticleData];
            }];
        });
    }];
}

//加载更多数据
- (void)loadMoreData
{
    if (page > 5) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:self.articleModel.channelPost.lastId forKey:@"lastId"];
    [parameters setValue:@(pageCount) forKey:@"pageCount"];
    [parameters setValue:@(1) forKey:@"type"];
    WeakSelf(self);
    [ZJLoadingView showLoadingInView:self];
    [ZJNetworkHelper requestGETWithRequestUrl:DiscoveryInsetNextPopularPosts withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual: @200]) {
            NSArray *data = responseObject[@"result"][@"posts"];
            for (NSDictionary *dic in data) {
                ZJDiscoverHotArticleModel *model = [ZJDiscoverHotArticleModel modelWithJSON:dic];
                [weakself.articleModel.channelPost.posts addObject:model];
                //初始化文章布局
                ZJDiscoverHotArticleCellLayout *layout = [[ZJDiscoverHotArticleCellLayout alloc] initWithStatus:model];
                [self.hotArticleData addObject:layout];
            }
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
                [weakself getArticleData];
            }];
        });
    }];
}
@end
