//
//  ZJDiscoverHotInsetCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/10.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotInsetCell.h"

@interface ZJDiscoverHotInsetCell ()<UICollectionViewDataSource,WaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZJDiscoverHotInsetCell

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
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

#pragma mark -----------------UICollectionViewDataSource-----------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJDiscoverHotInsetCellCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    [cell setupUIWithInset:_style model:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark -----------------WaterFlowLayoutDelegate-----------------

- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZJDiscoverInsetPostModel *model = self.dataArray[index];
    if (self.style == itemStyleSingle) {
        return model.realHeight + 40;
    }
    return model.realHeight / 2;
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
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

@end

@implementation ZJDiscoverHotInsetCellCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setupUIWithInset:(itemStyle)style model:(ZJDiscoverInsetPostModel *)model
{
    _model = model;
    //点赞
    self.profileView.praiseButton.selected = model.hasPraise;
    self.profileView.praiseBlock = ^(BOOL selected) {
        model.hasPraise = selected;
        NSLog(@"点赞---->%d",selected);
    };
    //是否显示Top icon
    if ((model.no == 1 || model.no == 2 || model.no == 3) && model.type == 2) {
        self.view.topImageView.hidden = NO;
        if (model.no == 1) {
            self.view.topImageView.image = [UIImage imageNamed:@"double_line_one"];
        }else if (model.no == 2){
            self.view.topImageView.image = [UIImage imageNamed:@"double_line_two"];
        }else{
            self.view.topImageView.image = [UIImage imageNamed:@"double_line_three"];
        }
    }else{
        self.view.topImageView.hidden = YES;
    }
    //单列模式
    UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
    if (style == itemStyleSingle) {
        if ((model.no == 1 || model.no == 2 || model.no == 3) && model.type == 2) {
            //插画前三显示Top图标，COS不显示
            self.view.topImageView.hidden = NO;
            self.view.topLabel.hidden = NO;
            if (model.no == 1) {
                self.view.topImageView.image = [UIImage imageNamed:@"double_line_one"];
                self.view.topLabel.text = @"昨日Top1";
            }else if (model.no == 2){
                self.view.topImageView.image = [UIImage imageNamed:@"double_line_two"];
                self.view.topLabel.text = @"昨日Top2";
            }else{
                self.view.topImageView.image = [UIImage imageNamed:@"double_line_three"];
                self.view.topLabel.text = @"昨日Top3";
            }
            //重新约束Top图标
            [self.view.topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
            }];
            [self.view.topLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.view.topImageView).with.offset(2);
            }];
        }
        self.view.bottomShadow.hidden = NO;
        self.profileView.backgroundColor = [ZJColor clearColor];
        self.profileView.thumbImageView.layer.cornerRadius = 25 * 0.5;
        [self.profileView.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(25);
        }];
        [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:model.author.portraitFullUrl] placeholder:placeholderAvatarImage];
        self.profileView.nameLabel.textColor = [ZJColor whiteColor];
        self.profileView.nameLabel.text = model.author.nickName;
    }else{
        //双列模式
        self.view.topLabel.hidden = YES;
        self.view.bottomShadow.hidden = YES;
        self.profileView.backgroundColor = [ZJColor whiteColor];
        self.profileView.thumbImageView.image = image;
        self.profileView.thumbImageView.layer.cornerRadius = 0;
        [self.profileView.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
        }];

        self.profileView.nameLabel.textColor = [ZJColor blackColor];
        self.profileView.nameLabel.text = model.author.nickName;
    }
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth * 2,model.realHeight * 2 + 40];
    [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
}

- (void)setupUIWithPost:(itemStyle)style model:(id)model
{

}

#pragma mark -----------------lazy-----------------

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZJDiscoverRecommendHotRecommendCellView *)view
{
    if (!_view) {
        _view = [[ZJDiscoverRecommendHotRecommendCellView alloc] init];
        [self.mainView addSubview:_view];
        [self.mainView sendSubviewToBack:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _view;
}

- (ZJDiscoverRecommendHotRecommendCellProfileView *)profileView
{
    if (!_profileView) {
        _profileView = [[ZJDiscoverRecommendHotRecommendCellProfileView alloc] init];
        [self.mainView addSubview:_profileView];
        [self.mainView bringSubviewToFront:_profileView];
        [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
    }
    return _profileView;
}

@end




