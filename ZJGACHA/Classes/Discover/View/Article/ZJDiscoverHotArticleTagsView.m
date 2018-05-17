//
//  ZJDiscoverHotArticleTagsView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotArticleTagsView.h"
#import "ZJTagModel.h"

@implementation ZJDiscoverHotArticleTagsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

//标签点击事件
- (void)btnEvent:(UIButton *)btn
{
    NSLog(@"点击%@",btn.titleLabel.text);
}

- (void)setupUI:(NSArray *)tags
{
    [self.btnArray removeAllObjects];
    [self.scrollView removeAllSubviews];
    UIButton *lastBtn;
    for (int i = 0; i < tags.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:btn];
        ZJTagModel *tagModel = [tags safeObjectAtIndex:i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.scrollView.mas_centerY).with.offset(5);
            make.height.mas_equalTo(25);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).with.offset(20);
            }else{
                make.left.mas_equalTo(self.scrollView.mas_left).with.offset(0);
            }
            if (tagModel.tagName.length == 1) {
                make.width.mas_equalTo(32);
            }else{
                if (i == 0) {
                    make.width.mas_equalTo(([NSString getTitleWidth:tagModel.tagName withFontSize:13]) + 40);
                }else{
                    make.width.mas_equalTo(([NSString getTitleWidth:tagModel.tagName withFontSize:13]) + 30);
                }
            }
            if (i == tags.count - 1) {
                make.right.mas_equalTo(self.scrollView.mas_right).with.offset(0);
            }
        }];
        [btn.superview layoutIfNeeded];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[ZJColor appSupportColor] forState:UIControlStateNormal];
        [btn setTitle:tagModel.tagName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        lastBtn = btn;

        //标签背景
        UIImage *bgImage = [UIImage imageNamed:@"circle_tag_n"];
        CGFloat top = 0; // 顶端盖高度
        CGFloat bottom = 0 ; // 底端盖高度
        CGFloat left = bgImage.size.width * 0.6; // 左端盖宽度
        CGFloat right = 5; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        //背景图拉伸
        bgImage = [bgImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        btn.adjustsImageWhenHighlighted = NO;
        if (i == 0) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.size = CGSizeMake(btn.height - 5, btn.height - 5);
            imageView.mj_x = 3;
            imageView.top = (btn.height - imageView.height) / 2.0;
            imageView.layer.cornerRadius = imageView.height / 2.0;
            imageView.layer.masksToBounds = YES;
            [imageView setImageWithURL:[NSURL URLWithString:tagModel.thumb] placeholder:placeholderAvatarImage];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
            [btn addSubview:imageView];
        }
    }
}

- (void)setupPostDetailTags:(NSArray *)tags
{
    [self.btnArray removeAllObjects];
    WeakSelf(self);
    [self.scrollView removeAllSubviews];
    UIButton *lastBtn;
    for (NSInteger i=0; i < tags.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:btn];
        ZJTagModel *model = [tags safeObjectAtIndex:i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakself.mas_centerY).with.offset(0);
            make.height.mas_equalTo(25);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(20);
            }else{
                make.left.mas_equalTo(self.scrollView.mas_left).offset(12);
            }
            if (model.tagName.length == 1) {
                make.width.mas_equalTo(32);
            }else{
                if (i == 0) {
                    make.width.mas_equalTo([NSString getTitleWidth:model.tagName withFontSize:13] + 40);
                }else{
                    make.width.mas_equalTo([NSString getTitleWidth:model.tagName withFontSize:13] + 30);
                }
            }
            if (i == tags.count-1) {
                make.right.mas_equalTo(self.scrollView.mas_right).offset(-20);
            }
        }];
        [btn.superview layoutIfNeeded];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[ZJColor appSupportColor] forState:UIControlStateNormal];
        [btn setTitle:model.tagName forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        lastBtn = btn;

        UIImage *image = [UIImage imageNamed:@"circle_tag_n"];
        CGFloat top = 0; // 顶端盖高度
        CGFloat bottom = 0 ; // 底端盖高度
        CGFloat left = image.size.width * 0.6; // 左端盖宽度
        CGFloat right = 5; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        btn.adjustsImageWhenHighlighted = NO;
        [self.btnArray addObject:btn];
    }
}

#pragma mark -----------------lazy-----------------
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _scrollView;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
@end
