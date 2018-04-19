//
//  ZJDiscoverArticleBannerCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverArticleBannerCell.h"
#import "ZMICarouselView.h"
#import "ZJDiscoverHotArticleModel.h"

@interface ZJDiscoverArticleBannerCell ()<ZMICarouselViewDelegate,ZMICarouselViewDataSource>

@property (nonatomic, strong) ZMICarouselView *icarouselView;

@end


@implementation ZJDiscoverArticleBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self iconView];
        [self remLabel];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.imagesArray removeAllObjects];
    for (ZJDiscoverHotArticleModel *articleModel in dataArray) {
        [self.imagesArray addObject:articleModel.fullUrl];
        self.remLabel.text = @"推荐写手";
    }
    [self.icarouselView reloadData];
    [self.icarouselView.carousel scrollToItemAtIndex:1 animated:NO];
    [self.icarouselView.carousel scrollToItemAtIndex:0 animated:NO];
}
#pragma mark -----------------iCarouselDelegate&iCarouselDataSource-----------------

- (NSArray *)numberOfItemsInZMICarouselView{
    return self.imagesArray;
}

- (void)ZMICarouselView:(ZMICarouselView *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了 = %ld",index);
    
}

- (void)ZMICarouselViews:(iCarousel *)carousel didScrollToIndex:(NSInteger)index{

    [self.icarouselView.carousel.currentItemView addSubview:self.maskImageView];
    [self updateConstraintsWithView];
    self.maskImageView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.maskImageView.hidden = NO;
    }];

    id model = [self.dataArray safeObjectAtIndex:index];
    if ([model isKindOfClass:[ZJDiscoverHotArticleModel class]]) {
        [self.thumbView setImageWithURL:[NSURL URLWithString:((ZJDiscoverHotArticleModel *)model).author.portraitFullUrl]  placeholder:placeholderFailImage];
        self.nickLabel.text = ((ZJDiscoverHotArticleModel *)model).author.nickName;
        self.descLabel.text = ((ZJDiscoverHotArticleModel *)model).author.signature;
        self.nameLabel.text = ((ZJDiscoverHotArticleModel *)model).title;
        self.tagLabel.text = ((ZJDiscoverHotArticleModel *)model).tag;
        self.readButton.hidden = NO;
    }
}

- (void)updateConstraintsWithView{
    [self.maskImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];

    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maskImageView.mas_left).with.offset(10);
        make.right.mas_equalTo(self.maskImageView.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.maskImageView.mas_top).with.offset(30);
        make.height.mas_equalTo(50);
    }];

    [self.tagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.maskImageView.mas_centerY);
        make.height.mas_equalTo(50);
    }];

    [self.readButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.maskImageView);
        make.bottom.mas_equalTo(self.maskImageView.mas_bottom).with.offset(-35);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}
#pragma mark -----------------lazy-----------------

- (ZMICarouselView *)icarouselView
{
    if (!_icarouselView) {
        _icarouselView = [ZMICarouselView icarouselViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
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
        _icarouselView.showBgMask = YES;
        [self.contentView addSubview:_icarouselView];
        [self.contentView sendSubviewToBack:_icarouselView];
        [_icarouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
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

- (UIImageView *)maskImageView
{
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc] init];
        _maskImageView.image = [UIImage imageNamed:@"discovery_feature_cell_mask"];
        [self.icarouselView.carousel addSubview:_maskImageView];
        [_maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _maskImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.numberOfLines =2;
        [self.maskImageView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(30);
            make.right.mas_equalTo(-10);
        }];
    }
    return _nameLabel;
}

- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = [ZJColor whiteColor];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.font = [UIFont systemFontOfSize:12];
        _tagLabel.numberOfLines = 2;
        [self.maskImageView addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.maskImageView.mas_centerY);
        }];
    }
    return _tagLabel;
}

- (UIButton *)readButton
{
    if (!_readButton) {
        _readButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _readButton.layer.cornerRadius =3;
        _readButton.layer.borderWidth = 1;
        _readButton.layer.borderColor = [ZJColor whiteColor].CGColor;
        [_readButton setTitleColor:[ZJColor whiteColor] forState:UIControlStateNormal];
        [_readButton setTitle:@"立即阅读" forState:UIControlStateNormal];
        _readButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.maskImageView addSubview:_readButton];
        [_readButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.maskImageView);
            make.bottom.mas_equalTo(-35);
            make.size.mas_equalTo(CGSizeMake(80, 35));
        }];
    }
    return _readButton;
}
@end
