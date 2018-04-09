//
//  ZJDiscoverRecommendHotRecommendCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/8.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendHotRecommendCell.h"

@interface ZJDiscoverRecommendHotRecommendCell ()<UICollectionViewDataSource,WaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation ZJDiscoverRecommendHotRecommendCell

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
        [_collectionView registerClass:[ZJDiscoverRecommendHotRecommendCollectionCell class] forCellWithReuseIdentifier:@"cell"];
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
    ZJDiscoverRecommendHotRecommendCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    [cell setupUIWithRecommend:_style model:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark -----------------WaterFlowLayoutDelegate-----------------

- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZJDiscoverHotRecommendModel *model = self.dataArray[index];
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

@implementation ZJDiscoverRecommendHotRecommendCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)setupUIWithRecommend:(itemStyle)style model:(ZJDiscoverHotRecommendModel *)model
{
    _model = model;
    //点赞
    self.profileView.praiseButton.selected = model.hasPraise;
    self.profileView.praiseBlock = ^(BOOL selected) {
        model.hasPraise = selected;
        NSLog(@"点赞---->%d",selected);
    };
    //是否显示Top icon
    if (model.top == 1) {
        self.view.topImageView.hidden = NO;
    }else{
        self.view.topImageView.hidden = YES;
    }
    //单列模式
    UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
    if (style == itemStyleSingle) {
        if (model.top == 1) {
            self.view.topLabel.hidden = NO;
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

@implementation ZJDiscoverRecommendHotRecommendCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZJImageView *)thumbImageView
{
    if (!_thumbImageView) {
        _thumbImageView = [[ZJImageView alloc] init];
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"double_line_one"];
        _topImageView.image = image;
        [self.mainView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _topImageView;
}
- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.backgroundColor = [ZJColor colorWithHexString:@"#000000" withAlpha:0.6];
        _topLabel.textColor = [ZJColor whiteColor];
        _topLabel.font = [UIFont systemFontOfSize:11];
        _topLabel.layer.cornerRadius = 12;
        _topLabel.layer.masksToBounds = YES;
        _topLabel.text = @"昨日Top1";
        _topLabel.textAlignment = NSTextAlignmentCenter;
        [self.thumbImageView addSubview:_topLabel];
        [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.mas_equalTo(10);
            make.centerX.mas_equalTo(self.topImageView).with.offset(2);
            make.top.mas_equalTo(self.topImageView.mas_bottom).with.offset(2);
            make.width.mas_equalTo([NSString getTitleWidth:@"昨日Top1" withFontSize:11] + 20);
            make.height.mas_equalTo(24);
        }];
    }
    return _topLabel;
}
- (UIImageView *)bottomShadow
{
    if (!_bottomShadow) {
        _bottomShadow = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"glist_name_bg"];
        _bottomShadow.image = image;
        [self.mainView addSubview:_bottomShadow];
        [_bottomShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.superview.height/2);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _bottomShadow;
}
@end

@implementation ZJDiscoverRecommendHotRecommendCellProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

//点赞
- (void)clickPraiseButton:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.praiseBlock) {
        self.praiseBlock(button.selected);
    }
}

#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView
{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
        _thumbImageView.image = image;
        _thumbImageView.layer.cornerRadius = (image.size.width + 5) * 0.5;
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.mainView);
            make.size.mas_equalTo(CGSizeMake(image.size.width + 5, image.size.height + 5));
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.right.mas_equalTo(self.praiseButton.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nameLabel;
}

- (UIButton *)praiseButton
{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.userInteractionEnabled = YES;
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateSelected];
        [self.mainView addSubview:_praiseButton];
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mainView.mas_right).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mainView);
        }];
        [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseButton;
}

@end
