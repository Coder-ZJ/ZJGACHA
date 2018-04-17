//
//  ZJDiscoverInsetBannerCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverInsetBannerCell.h"
#import "ZMICarouselView.h"
#import "ZJWorksModel.h"

@interface ZJDiscoverInsetBannerCell ()<ZMICarouselViewDelegate,ZMICarouselViewDataSource>

@property (nonatomic, strong) ZMICarouselView *icarouselView;

@end

@implementation ZJDiscoverInsetBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self iconView];
        [self remLabel];
    }
    return self;
}
- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    [self.imagesArray removeAllObjects];
    for (ZJWorksModel *model in dataArray) {
        ZJWorkModel *workModel = [model.work safeObjectAtIndex:0];
        [self.imagesArray addObject:workModel.fullUrl];
        //推荐类型名
        if (workModel.type == 2) {
            self.remLabel.text = @"推荐画师";
        }else{
            self.remLabel.text = @"推荐Coser";
        }
    }
    [self.icarouselView reloadData];
    id model = [dataArray safeObjectAtIndex:0];
    if ([model isKindOfClass:[ZJWorksModel class]]) {
        [self.thumbView setImageWithURL:[NSURL URLWithString:((ZJWorksModel *)model).author.portraitFullUrl]  placeholder:placeholderFailImage];
        self.nickLabel.text = ((ZJWorksModel *)model).author.nickName;
        self.descLabel.text = ((ZJWorksModel *)model).author.signature;
    }
}
#pragma mark -----------------iCarouselDelegate&iCarouselDataSource-----------------

- (NSArray *)numberOfItemsInZMICarouselView{
    return self.imagesArray;
}

- (void)ZMICarouselView:(ZMICarouselView *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了 = %ld",index);
    
}

- (void)ZMICarouselViews:(iCarousel *)carousel didScrollToIndex:(NSInteger)index{
    id model = [self.dataArray safeObjectAtIndex:index];
    if ([model isKindOfClass:[ZJWorksModel class]]) {
        [self.thumbView setImageWithURL:[NSURL URLWithString:((ZJWorksModel *)model).author.portraitFullUrl]  placeholder:placeholderFailImage];
        self.nickLabel.text = ((ZJWorksModel *)model).author.nickName;
        self.descLabel.text = ((ZJWorksModel *)model).author.signature;
    }
}

#pragma mark -----------------lazy-----------------

- (ZMICarouselView *)icarouselView
{
    if (!_icarouselView) {
        _icarouselView = [ZMICarouselView icarouselViewWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _icarouselView.dataSource = self;
        _icarouselView.delegate = self;
        _icarouselView.showPageControl = YES;
        _icarouselView.pageControlStyle = ZMICarouselPageContolStyleAnimated;
        _icarouselView.currentPageDotColor = [ZJColor whiteColor];
        _icarouselView.pageControlAliment = ZMICarouselPageContolAligmentCenter;
        _icarouselView.autoScroll = YES;
        _icarouselView.infiniteLoop = YES;
        _icarouselView.pageControlBottomOffset = -5;
        _icarouselView.autoScrollTimeInterval = 5;
        [self.contentView addSubview:_icarouselView];
        [self.contentView sendSubviewToBack:_icarouselView];
    }
    return _icarouselView;
}

- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] init];
    }
    return _imagesArray;
}

- (UIImageView *)thumbView
{
    if (!_thumbView) {
        _thumbView = [[UIImageView alloc] init];
        _thumbView.layer.cornerRadius = 30 * 0.5;
        _thumbView.layer.masksToBounds = YES;
        _thumbView.layer.borderColor = [ZJColor whiteColor].CGColor;
        _thumbView.layer.borderWidth = 1;
        [self.contentView addSubview:_thumbView];
        [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _thumbView;
}

- (UILabel *)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] init];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.thumbView);
        }];
    }
    return _nickLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [ZJColor whiteColor];
        _descLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickLabel);
            make.top.mas_equalTo(self.thumbView.mas_bottom).with.offset(2);
            make.right.mas_equalTo(-20);
        }];
    }
    return _descLabel;
}

- (UILabel *)remLabel
{
    if (!_remLabel) {
        _remLabel = [[UILabel alloc] init];
        _remLabel.textColor = [ZJColor whiteColor];
        _remLabel.font = [UIFont systemFontOfSize:13];
        _remLabel.text = @"推荐画师";
        [self.contentView addSubview:_remLabel];
        [_remLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.thumbView);
        }];
        [_remLabel sizeToFit];
    }
    return _remLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"GCDiscovery_banner_star~iphone"];
        _iconView.image = image;
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.remLabel.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.remLabel.mas_centerY).with.offset(-1);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _iconView;
}
@end
