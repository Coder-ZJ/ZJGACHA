//
//  ZJPostDetailView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailView.h"
#import "ZJPostDetailBottomToolView.h"
#import "ZJPostDetailModel.h"
#import "ZJPostDetailCell.h"
#import "ZJPostDetailPraiseAuthorModel.h"
#import "ZJPostDetailHeaderView.h"
#import "ZJDiscoverHeadModel.h"
#import "ZJPostDetailCommentModel.h"
#import "ZJPostDetailCommentCell.h"

@interface ZJPostDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZJPostDetailBottomToolView *bottomToolView;
@property (nonatomic, strong) ZJBaseTableView *tableView;
@property (nonatomic, strong) ZJPostDetailModel *postDetailModel;
@property (nonatomic, strong) ZJPostDetailHeaderView *relatedHeadView;
@property (nonatomic, strong) ZJPostDetailHeaderView *hotCommentHeadView;
@property (nonatomic, strong) ZJPostDetailHeaderView *commentHeadView;

@property (nonatomic, strong) NSMutableArray *hotCommentArray;
@property (nonatomic, strong) NSMutableArray *commentArray;

@end

@implementation ZJPostDetailView
{
    NSInteger count,page;
}
#pragma mark -----------------lazy-----------------
- (NSMutableArray *)hotCommentArray
{
    if (!_hotCommentArray) {
        _hotCommentArray = [[NSMutableArray alloc] init];
    }
    return _hotCommentArray;
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [[NSMutableArray alloc] init];
    }
    return _commentArray;
}

- (ZJPostDetailBottomToolView *)bottomToolView
{
    if (!_bottomToolView) {
        _bottomToolView = [[ZJPostDetailBottomToolView alloc] initWithFrame:CGRectZero];
        [self addSubview:_bottomToolView];
        [_bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
        _bottomToolView.count = 90;
    }
    return _bottomToolView;
}

- (ZJBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[ZJBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
         [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomToolView.mas_top).with.offset(0);
        }];

        [_tableView registerClass:[ZJPostDetailRankCell class] forCellReuseIdentifier:@"rankCell"];
        [_tableView registerClass:[ZJPostDetailUserInfoCell class] forCellReuseIdentifier:@"userInfoCell"];
        [_tableView registerClass:[ZJPostDetailTextContentCell class] forCellReuseIdentifier:@"textContentCell"];
        [_tableView registerClass:[ZJPostDetailImageListCell class] forCellReuseIdentifier:@"imageListCell"];
        [_tableView registerClass:[ZJPostDetailTagsCell class] forCellReuseIdentifier:@"tagsCell"];
        [_tableView registerClass:[ZJPostDetailRelatedCell class] forCellReuseIdentifier:@"relatedCell"];
        [_tableView registerClass:[ZJPostDetailPraiseCell class] forCellReuseIdentifier:@"praiseCell"];
        [_tableView registerClass:[ZJPostDetailCommentCell class] forCellReuseIdentifier:@"commentCell"];

        WeakSelf(self);
        _tableView.mj_footer = [ZJRefreshGifFooter footerWithRefreshingBlock:^{
            page++;
            [weakself getPostDetailCommentData];
        }];
    }
    return _tableView;
}

- (ZJPostDetailHeaderView *)relatedHeadView
{
    if (!_relatedHeadView) {
        _relatedHeadView = [[ZJPostDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"猜你喜欢";
        headModel.icon = [YYImage imageNamed:@"postDetail_recommendIcon~iphone"];
        _relatedHeadView.titleLabel.textColor = [ZJColor appSupportColor];
        _relatedHeadView.headModel = headModel;
        _relatedHeadView.bottomLine.hidden = YES;
    }
    return _relatedHeadView;
}

- (ZJPostDetailHeaderView *)hotCommentHeadView
{
    if (!_hotCommentHeadView) {
        _hotCommentHeadView = [[ZJPostDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"热门评论";
        headModel.icon = [YYImage imageNamed:@"postDetail_section_hotCommentIcon~iphone"];
        _hotCommentHeadView.titleLabel.textColor = [ZJColor colorWithRed:246 withGreen:118 withBlue:127 withAlpha:1.0];
        _hotCommentHeadView.headModel = headModel;
    }
    return _hotCommentHeadView;
}

- (ZJPostDetailHeaderView *)commentHeadView
{
    if (!_commentHeadView) {
        _commentHeadView = [[ZJPostDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        ZJDiscoverHeadModel *headModel = [[ZJDiscoverHeadModel alloc] init];
        headModel.title = @"全部评论";
        headModel.icon = [YYImage imageNamed:@"postDetaial_section_icon~iphone"];
        _commentHeadView.titleLabel.textColor = [ZJColor appSupportColor];
        _commentHeadView.headModel = headModel;
    }
    return _commentHeadView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        count = 10;
        page = 0;
    }
    return self;
}
- (void)setPostId:(NSString *)postId
{
    [self bottomToolView];
    _postId = postId;

    [self getPostDetailData];
}
#pragma mark -----------------UITableViewDelegate-----------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //1- :榜、用户、标题、图片、标签 2- :喜欢的人 3- :猜你喜欢 4- :热门评论 5- :全部评论
    if (self.hotCommentArray.count) {
        return 5;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = self.commentArray.count == 0;
    if (section == 0) {
        return 5;
    }else if (section == 1 || section == 2) {
        return 1;
    }else if (section == 3) {
        if (self.hotCommentArray.count) {
            return self.hotCommentArray.count;
        }
        return self.commentArray.count;
    }else if (section == 4) {
        return self.commentArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 45;
        }else if (indexPath.row == 1) {
            return 70;
        }else if (indexPath.row == 2) {
            return self.postDetailModel.richTextHeight;
        }else if (indexPath.row == 3) {
            return self.postDetailModel.imagesHeight;
        }else if (indexPath.row == 4 && self.postDetailModel.tags.count) {
            return 60;
        }
        return 0;
    }else if (indexPath.section == 1 && self.postDetailModel.supportCount) {
        return 65;
    }else if (indexPath.section == 2 && self.postDetailModel.relatedPosts.count) {
        return [self.postDetailModel.relatedPosts firstObject].cover.realHeight;
    }else if (indexPath.section == 3) {
        if (self.hotCommentArray.count) {
            return ((ZJPostDetailCommentModel *)[self.hotCommentArray objectAtIndex:indexPath.row]).height;
        }
        return ((ZJPostDetailCommentModel *)[self.commentArray objectAtIndex:indexPath.row]).height;
    }else if (indexPath.section == 4) {
        return ((ZJPostDetailCommentModel *)[self.commentArray objectAtIndex:indexPath.row]).height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 4) {
        return 50;
    }else if (section == 3) {
        return 50;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!self.commentArray.count && section == 3) {
        return 0.5;
    }
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return self.relatedHeadView;
    }else if (section == 3) {
        if (self.hotCommentArray.count) {
            return self.hotCommentHeadView;
        }
         return self.commentHeadView;
    }else if (section == 4) {
        return self.commentHeadView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZJPostDetailRankCell *rankCell = [tableView dequeueReusableCellWithIdentifier:@"rankCell"];
            return rankCell;
        }else if (indexPath.row == 1){
            ZJPostDetailUserInfoCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell"];
            userInfoCell.postDetailModel = self.postDetailModel;
            return userInfoCell;
        }else if (indexPath.row == 2) {
            ZJPostDetailTextContentCell *textContentCell = [tableView dequeueReusableCellWithIdentifier:@"textContentCell"];
            textContentCell.postDetailModel = self.postDetailModel;
            return textContentCell;
        }else if (indexPath.row == 3) {
            ZJPostDetailImageListCell *imageListCell = [tableView dequeueReusableCellWithIdentifier:@"imageListCell"];
            imageListCell.postDetailModel = self.postDetailModel;
            return imageListCell;
        }else{
            ZJPostDetailTagsCell *tagsCell = [tableView dequeueReusableCellWithIdentifier:@"tagsCell"];
            tagsCell.postDetailModel = self.postDetailModel;
            return tagsCell;
        }
    }else if (indexPath.section == 1 && self.postDetailModel.supportArray.count) {
        ZJPostDetailPraiseCell *praiseCell = [tableView dequeueReusableCellWithIdentifier:@"praiseCell"];
        praiseCell.postDetailModel = self.postDetailModel;
        return praiseCell;
    }else if (indexPath.section == 2 && self.postDetailModel.relatedPosts.count) {
        ZJPostDetailRelatedCell *relatedCell = [tableView dequeueReusableCellWithIdentifier:@"relatedCell"];
        relatedCell.contentView.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        relatedCell.contentView.width = kScreenWidth;
        relatedCell.postDetailModel = self.postDetailModel;
        return relatedCell;
    }else if (indexPath.section == 3) {
        ZJPostDetailCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        commentCell.commentUserView.topLine.hidden = indexPath.row ? NO : YES;
        if (self.hotCommentArray.count) {
            commentCell.commentModel = self.hotCommentArray[indexPath.row];
        }else{
            commentCell.commentModel = self.commentArray[indexPath.row];
        }
        return commentCell;
    }else if (indexPath.section == 4 && self.commentArray.count) {
        ZJPostDetailCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        commentCell.commentUserView.topLine.hidden = indexPath.row ? NO : YES;
        commentCell.commentModel = self.commentArray[indexPath.row];
        return commentCell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark -----------------网络请求-----------------
//帖子详情
- (void)getPostDetailData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:_postId forKey:@"postID"];
    WeakSelf(self);
    [ZJLoadingView showLoadingInView:self];
    [ZJNetworkHelper requestGETWithRequestUrl:PostDetailInfo withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual:@200]) {
            weakself.postDetailModel = [ZJPostDetailModel modelWithJSON:responseObject[@"result"]];
            [weakself getPostDetailPraiseData];
            [weakself getPostDetailHotCommentData];
            [weakself getPostDetailCommentData];

            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:weakself];
                //底部工具栏赋值
                weakself.bottomToolView.collectButton.selected = weakself.postDetailModel.isCollect;
                weakself.bottomToolView.praiseButton.selected = weakself.postDetailModel.isSupport;
                if (weakself.postDetailModel.commentCount) {
                    [weakself.bottomToolView.commentButton setTitle:[NSString stringWithFormat:@"评论(%ld)",weakself.postDetailModel.commentCount] forState:UIControlStateNormal];
                }
                weakself.bottomToolView.praiseCountLabel.text = [NSString stringWithFormat:@"%ld",weakself.postDetailModel.supportCount];
                [weakself.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJLoadingView hideLoadingForView:weakself];
            });
        }
    } withFailure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJLoadingView hideLoadingForView:weakself];
            [ZJLoadFailedView showLoadFailedInView:weakself topEdge:0 retryHandle:^{
                [weakself getPostDetailData];
            }];
        });
    }];
}

//喜欢的人
- (void)getPostDetailPraiseData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:_postId forKey:@"postId"];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:PostSupportUsersList withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual:@200]) {
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in responseObject[@"result"]) {
                ZJPostDetailPraiseAuthorModel *authorModel = [ZJPostDetailPraiseAuthorModel modelWithJSON:dic];
                [temp addObject:authorModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.postDetailModel.supportArray = temp;
                [weakself.tableView reloadData];
            });
        }else{

        }
    } withFailure:^(NSError *error) {

    }];
}

//热门评论
- (void)getPostDetailHotCommentData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:_postId forKey:@"postID"];
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:PostHotcommentsList withParameters:parameters withSuccess:^(id responseObject) {
        if ([responseObject[@"code"] isEqual:@200]) {
            for (NSDictionary *dic in responseObject[@"result"]) {
                ZJPostDetailCommentModel *commentModel = [ZJPostDetailCommentModel modelWithJSON:dic];
                [weakself.hotCommentArray addObject:commentModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
        }else{

        }
    } withFailure:^(NSError *error) {

    }];
}

//全部评论
- (void)getPostDetailCommentData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:_postId forKey:@"postID"];
    [parameters setValue:@(count) forKey:@"commentCount"];
    [parameters setValue:@(page) forKey:@"dir"];
    if (self.commentArray.count) {
        NSString *postID = ((ZJPostDetailCommentModel *)[self.commentArray lastObject]).cid;
        [parameters setValue:postID forKey:@"startCommentID"];
    }
    WeakSelf(self);
    [ZJNetworkHelper requestGETWithRequestUrl:PostCommentsList withParameters:parameters withSuccess:^(id responseObject) {
        NSArray *result = responseObject[@"result"];
        if ([responseObject[@"code"] isEqual:@200]) {
            for (NSDictionary *dic in responseObject[@"result"]) {
                ZJPostDetailCommentModel *commentModel = [ZJPostDetailCommentModel modelWithJSON:dic];
                [weakself.commentArray addObject:commentModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakself.commentArray.count) {
                    [weakself emptyView];
                }else{
                    weakself.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                }
                if (result.count < count) {
                    [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakself.tableView.mj_footer endRefreshing];
                }
                [weakself.tableView reloadData];
            });
        }else{

        }
    } withFailure:^(NSError *error) {

    }];
}
- (void)emptyView
{
    XBDPublicEmptyView *emptyView = [[XBDPublicEmptyView alloc] initWithTitle:@"" secondTitle:@"" iconname:@"post_detail_no_comment~iphone"];
    emptyView.frame = CGRectMake(0, 0, kScreenWidth, 250);
    emptyView.backgroundColor = [ZJColor whiteColor];
    self.tableView.tableFooterView = emptyView;
}
@end

