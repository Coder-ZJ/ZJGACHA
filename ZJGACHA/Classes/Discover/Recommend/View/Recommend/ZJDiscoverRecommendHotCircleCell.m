//
//  ZJDiscoverRecommendHotCircleCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/4.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRecommendHotCircleCell.h"


@interface ZJDiscoverRecommendHotCircleCell ()

/** 记录最后一个数量 */
@property (nonatomic, assign) NSInteger lastCount;
/** 底部视图 */
@property (nonatomic, strong) UIView    *bottomV;
/** 存储数据 */
@property (nonatomic, strong) NSArray   *dataArray;
/** 最后一个按钮 */
@property (nonatomic, strong) ZJDiscoverRecommendHotCircleCellView *lastBTN;

@end

@implementation ZJDiscoverRecommendHotCircleCell
{
    CGFloat cellLineCount;
    CGFloat cellLineSpace;
    CGFloat cellWidth;
    CGFloat cellHeight;
    CGFloat leftMargin;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        cellLineCount = 3;
        cellLineSpace = 2;
        leftMargin    = 10;
        cellWidth     = (kScreenWidth - leftMargin * 2 - (cellLineCount - 1) * cellLineSpace)/3;
        cellHeight    = cellWidth + 18 + 5 + 15 + 8 + 30 + 8;
    }
    return self;
}

- (void)setupUI:(NSArray *)array
{
    self.dataArray = array;

    //初始化视图
    for (int i = 1; i <= array.count; i++) {
        ZJDiscoverRecommendHotCircleCellView *view = [self viewWithTag:i * 10];
        if (!view) {
            view = [self setupView:[array safeObjectAtIndex:i - 1] tag:i * 10];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!_lastBTN) {
                    make.left.mas_equalTo(self.bottomV.mas_left).offset(leftMargin);
                    make.top.mas_equalTo(self.bottomV.mas_top).with.offset(cellLineSpace);
                }else{
                    //左边
                    if (i % 3 == 1) {
                        make.left.mas_equalTo(self.bottomV.mas_left).offset(leftMargin);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (cellHeight  + cellLineSpace) + cellLineSpace);
                    }else if(i % 3 == 2){
                        make.left.mas_equalTo(cellWidth  + leftMargin + cellLineSpace);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (cellHeight  + cellLineSpace) + cellLineSpace);
                    }else if (i % 3 == 0){
                        make.right.mas_equalTo(self.bottomV.mas_right).offset(- leftMargin);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (cellHeight  + cellLineSpace) +cellLineSpace);
                    }
                }
            }];
        }else{
            view.model = [array safeObjectAtIndex:i - 1];
        }
        _lastBTN = view;
    }
    //删除
    for (NSInteger j = array.count; j < _lastCount; j++) {
        UIButton *btn = [self viewWithTag:j*10];
        [btn removeFromSuperview];
        btn = nil;
    }
    _lastCount = array.count;
}
- (ZJDiscoverRecommendHotCircleCellView *) setupView:(ZJDiscoverHotCirleModel *)model tag:(NSInteger)tag{
    ZJDiscoverRecommendHotCircleCellView *view = [[ZJDiscoverRecommendHotCircleCellView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
    view.tag = tag;
    [self.bottomV addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(cellWidth);
        make.height.mas_equalTo(cellHeight);
    }];
    //设置数据
    view.model = model;
    return view;
}
#pragma mark -----------------lazy-----------------
- (UIView *)bottomV
{
    if (!_bottomV) {
        _bottomV = [[UIView alloc] init];
        [self.contentView addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _bottomV;
}
@end


@implementation ZJDiscoverRecommendHotCircleCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mainView];
        [self intoButton];
    }
    return self;
}

- (void)setModel:(ZJDiscoverHotCirleModel *)model
{
    _model = model;
    NSString *rightCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,model.circlePic,HttpImageURLSuffixSquare,model.imageSuffix];
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:rightCover] placeholder:placeholderFailImage];
    self.nameLabel.text  = model.circleName;
    self.numLabel.text = [NSString stringWithFormat:@"人气%@",model.allCount];
}
#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 3;
        _mainView.layer.borderWidth = 0.5;
        _mainView.layer.borderColor = [ZJColor appLightGrayColor].CGColor;
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
        _thumbImageView.layer.cornerRadius = (self.mainView.width - 20) * 0.5;
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.image = placeholderFailImage;
        [self.mainView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(_mainView.width - 20);
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.thumbImageView.mas_bottom).with.offset(5);
            make.height.mas_equalTo(18);
        }];
    }
    return _nameLabel;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = [ZJColor appSupportColor];
        _numLabel.font = [UIFont systemFontOfSize:13];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [self.mainView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.height.mas_equalTo(15);
        }];
    }
    return _numLabel;
}

- (UIButton *)intoButton
{
    if (!_intoButton) {
        _intoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_intoButton setTitle:@"进入" forState:UIControlStateNormal];
        [_intoButton setTitleColor:[ZJColor whiteColor] forState:UIControlStateNormal];
        _intoButton.backgroundColor = [ZJColor appMainColor];
        _intoButton.layer.cornerRadius = 3;
        _intoButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_intoButton];
        [_intoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.numLabel.mas_bottom).with.offset(8);
            make.height.mas_equalTo(30);
        }];
    }
    return _intoButton;
}
@end
