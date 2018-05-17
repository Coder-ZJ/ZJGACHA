//
//  ZJPostDetailBottomToolView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailBottomToolView.h"

@implementation ZJPostDetailBottomToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor colorWithHexString:@"ffffff" withAlpha:0.5];
        [self commentButton];
    }
    return self;
}
- (void)setCount:(NSInteger)count
{
    _count = count;
    self.praiseCountLabel.text = [NSString stringWithFormat:@"%ld",count];
    [self.praiseCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSString getTitleWidth:[NSString stringWithFormat:@"%ld",count] withFontSize:11] + 15);
    }];
}
#pragma mark -----------------ButtonEvent-----------------
- (void)collectButtonEvent:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.clickCollectBlock) {
        self.clickCollectBlock(btn.selected);
    }
}

- (void)praiseButtonEvetn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (self.clickPraiseBlock) {
        self.clickPraiseBlock(btn.selected);
    }
}
#pragma mark -----------------lazy-----------------
- (UIButton *)collectButton
{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectButton.adjustsImageWhenHighlighted = NO;
        UIImage *image = [UIImage imageNamed:@"postDetail_collect_default~iphone"];
        [_collectButton setImage:image forState:UIControlStateNormal];
        [_collectButton setImage:[UIImage imageNamed:@"postDetail_collect~iphone"] forState:UIControlStateSelected];
        [_collectButton addTarget:self action:@selector(collectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_collectButton];
        [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(50);
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _collectButton;
}

- (UIButton *)praiseButton
{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.adjustsImageWhenHighlighted = NO;
        UIImage *image = [UIImage imageNamed:@"postDetail_support_default~iphone"];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"postDetail_support_default_bg~iphone"] forState:UIControlStateNormal];
        [_praiseButton setBackgroundImage:[YYImage imageWithColor:[ZJColor clearColor]] forState:UIControlStateSelected];
        [_praiseButton setImage:image forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"postDetail_support~iphone"] forState:UIControlStateSelected];
        [_praiseButton addTarget:self action:@selector(praiseButtonEvetn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_praiseButton];
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.collectButton);
            make.centerY.mas_equalTo(self);
            make.right.mas_equalTo(self.mas_right).with.offset(-50);
        }];
    }
    return _praiseButton;
}

- (UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.adjustsImageWhenHighlighted = NO;
        _commentButton.backgroundColor = [ZJColor appSubBlueColor];
        _commentButton.layer.cornerRadius = 20;
        _commentButton.layer.masksToBounds = YES;
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_commentButton setTitleColor:[ZJColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_commentButton];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.collectButton.mas_right).with.offset(20);
            make.right.mas_equalTo(self.praiseButton.mas_left).with.offset(-20);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _commentButton;
}
- (UILabel *)praiseCountLabel
{
    if (!_praiseCountLabel) {
        _praiseCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _praiseCountLabel.layer.cornerRadius = 6;
        _praiseCountLabel.layer.masksToBounds = YES;
        _praiseCountLabel.textAlignment = NSTextAlignmentCenter;
        _praiseCountLabel.backgroundColor = [ZJColor colorWithHexString:@"#666666"];
        _praiseCountLabel.textColor = [ZJColor whiteColor];
        _praiseCountLabel.font = [UIFont systemFontOfSize:11];
        [self.praiseButton addSubview:_praiseCountLabel];
        [_praiseCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.praiseButton.mas_right).with.offset(-10);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(2);
        }];

    }
    return _praiseCountLabel;
}
@end
