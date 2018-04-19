//
//  ZJDiscoverRecommendHotTopicCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendHotTopicCell.h"
#import "ZJDiscoverHotTopicModel.h"

@implementation ZJDiscoverRecommendHotTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.bigImageView.backgroundColor = [UIColor redColor];
    self.leftImageView.backgroundColor = [UIColor redColor];
    self.rightImageView.backgroundColor = [UIColor redColor];
}
- (void)setupUI:(NSArray *)hotTopicArray
{

    if (!hotTopicArray.count) {
        return;
    }
    NSString *bigCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:0]).cover,HttpImageURLSuffixScanle(@"750", @"380"),((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:0]).imageSuffix];
    NSString *leftCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:1]).cover,HttpImageURLSuffixSquare,((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:1]).imageSuffix];
    NSString *rightCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:2]).cover,HttpImageURLSuffixSquare,((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:2]).imageSuffix];

    [self.bigImageView.bgImageView setAnimationLoadingImage:[NSURL URLWithString:bigCover] placeholder:placeholderFailImage];
    [self.leftImageView.bgImageView setAnimationLoadingImage:[NSURL URLWithString:leftCover] placeholder:placeholderFailImage];
    [self.rightImageView.bgImageView setAnimationLoadingImage:[NSURL URLWithString:rightCover] placeholder:placeholderFailImage];

    self.bigImageView.numLabel.text = [NSString stringWithFormat:@"%llu",((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:0]).num];
    self.leftImageView.numLabel.text = [NSString stringWithFormat:@"%llu",((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:1]).num];
    self.rightImageView.numLabel.text = [NSString stringWithFormat:@"%llu",((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:2]).num];

    self.bigImageView.nameLabel.text = ((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:0]).name;
    self.bigImageView.descLabel.text =  ((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:0]).desc;
    self.bigImageView.descLabel.numberOfLines = 1;
    self.bigImageView.descLabel.textAlignment = NSTextAlignmentLeft;
    self.bigImageView.descLabel.font = [UIFont systemFontOfSize:13];
    [self.bigImageView.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageView.dayLabel.mas_right).with.offset(5);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.bigImageView.nameLabel.mas_bottom).with.offset(5);
    }];


    self.leftImageView.descLabel.text =  ((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:1]).name;
    self.rightImageView.descLabel.text =  ((ZJDiscoverHotTopicModel *)[hotTopicArray safeObjectAtIndex:2]).name;

    NSArray *arr = [NSString getNowMonthAndDay];

    self.bigImageView.monthLabel.text = [arr safeObjectAtIndex:0];
    self.bigImageView.dayLabel.text = [arr safeObjectAtIndex:1];

    [self.bigImageView setupCornerRadiusWithDay];
}

- (void)clickJumpTopic:(NSInteger)index
{

}
#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (ZJDiscoverRecommendHotTopicCellView *)bigImageView
{
    if (!_bigImageView) {
        _bigImageView = [[ZJDiscoverRecommendHotTopicCellView alloc] init];
        [self.mainView addSubview:_bigImageView];
        [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(190 * FIT_WIDTH);
        }];
        WeakSelf(self);
        _bigImageView.clickBlock = ^{
            [weakself clickJumpTopic:100];
        };
    }
    return _bigImageView;
}

- (ZJDiscoverRecommendHotTopicCellView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[ZJDiscoverRecommendHotTopicCellView alloc] init];
        [self.mainView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.bigImageView.mas_bottom).with.offset(2);
            make.height.width.mas_equalTo((kScreenWidth - 2) / 2.0);
        }];
        WeakSelf(self);
        _leftImageView.clickBlock = ^{
            [weakself clickJumpTopic:110];
        };
    }
    return _leftImageView;
}

- (ZJDiscoverRecommendHotTopicCellView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[ZJDiscoverRecommendHotTopicCellView alloc] init];
        [self.mainView addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.bigImageView.mas_bottom).with.offset(2);
            make.height.width.mas_equalTo((kScreenWidth - 2) / 2.0);
        }];
        WeakSelf(self);
        _rightImageView.clickBlock = ^{
            [weakself clickJumpTopic:120];
        };
    }
    return _rightImageView;
}

@end


@implementation ZJDiscoverRecommendHotTopicCellView

- (void)setupCornerRadiusWithDay
{
    UIBezierPath *monthPath = [UIBezierPath bezierPathWithRoundedRect:self.monthLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *monthLayer = [[CAShapeLayer alloc] init];
    monthLayer.frame = self.monthLabel.bounds;
    monthLayer.path = monthPath.CGPath;
    self.monthLabel.layer.mask  = monthLayer;

    UIBezierPath *dayPath = [UIBezierPath bezierPathWithRoundedRect:self.dayLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *dayLayer = [[CAShapeLayer alloc] init];
    dayLayer.frame = self.dayLabel.bounds;
    dayLayer.path = dayPath.CGPath;
    self.dayLabel.layer.mask  = dayLayer;
}

//点击事件
- (void)clickImage:(UITapGestureRecognizer *)tap
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
        _mainView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [_mainView addGestureRecognizer:tap];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [ZJColor colorWithRed:0 withGreen:0 withBlue:0 withAlpha:0.2];
        [self.mainView addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _maskView;
}

- (ZJImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[ZJImageView alloc] init];
        [self.mainView addSubview:_bgImageView];
        [self.mainView sendSubviewToBack:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _bgImageView;
}

- (UILabel *)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = [ZJColor whiteColor];
        _monthLabel.backgroundColor = [ZJColor blackColor];
        _monthLabel.font = [UIFont systemFontOfSize:10];
        [self.maskView addSubview:_monthLabel];
        [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.bottom.mas_equalTo(self.dayLabel.mas_top).with.offset(0);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(35);
        }];
        [_monthLabel.superview layoutIfNeeded];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.backgroundColor = [ZJColor whiteColor];
        _dayLabel.textColor = [ZJColor blackColor];
        _dayLabel.font = [UIFont systemFontOfSize:10];
        [self.maskView addSubview:_dayLabel];
        [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.bottom.mas_equalTo(-35);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(35);
        }];
        [_dayLabel.superview layoutIfNeeded];
    }
    return _dayLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.maskView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dayLabel.mas_right).with.offset(5);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.dayLabel.mas_top);
        }];
    }
    return _nameLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [ZJColor whiteColor];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.numberOfLines =2;
        _descLabel.textAlignment = NSTextAlignmentCenter;
        [self.maskView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    return _descLabel;
}

- (UIImageView *)numImageView
{
    if (!_numImageView) {
        _numImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"pic_number_tag"];
        _numImageView.image = image;
        [self.maskView addSubview:_numImageView];
        [_numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.top.mas_equalTo(2);
            make.right.mas_equalTo(-2);
        }];
    }
    return _numImageView;
}

- (UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.font = [UIFont systemFontOfSize:10];
        _numLabel.textColor = [ZJColor whiteColor];
        [self.numImageView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.numImageView).with.offset(-2);
            make.centerY.mas_equalTo(self.numImageView).with.offset(2);
        }];
    }
    return _numLabel;
}
@end
