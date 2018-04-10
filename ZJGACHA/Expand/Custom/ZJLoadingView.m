//
//  ZJLoadingView.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJLoadingView.h"

static NSArray *s_refreshingImages = nil;

@implementation ZJLoadingView

+ (instancetype)loadViewWithFrame:(CGRect)frame{
    ZJLoadingView *loadView = [[self alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    return loadView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"loadingcai2new001"];
        _imageView.size = CGSizeMake(image.size.width, image.size.height);
        _imageView.left = (self.width - _imageView.size.width) / 2.0;
        _imageView.top = (self.height - _imageView.size.height) / 2.0 - _imageView.size.height/4;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZJColor appGraySpaceColor];
        [self addAnimalImages];
    }
    return self;
}
- (NSArray *)refreshingImages{
    if (!s_refreshingImages) {
        NSMutableArray *refreshingImages  = [NSMutableArray array];
        for (int i = 1; i < 25; ++i) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadingcai2new00%d",i]];
            [refreshingImages addObject:image];
        }
        s_refreshingImages = [refreshingImages copy];
    }
    return s_refreshingImages;
}

- (void)addAnimalImages{
    self.imageView.animationDuration = 1.5;
    self.imageView.animationImages = [self refreshingImages];
}

+ (void)showLoadingInView:(UIView *)view{
    [self showLoadingInView:view edgeInset:UIEdgeInsetsZero];
}

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset{
    ZJLoadingView *loadingView = [self loadViewWithFrame:view.frame];

    loadingView.edgeInset = edgeInset;

    [loadingView showInView:view];
}

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge{
    ZJLoadingView *loadingView = [self loadViewWithFrame:view.frame];
    loadingView.edgeInset = UIEdgeInsetsMake(topEdge, 0, 0, 0);
    [loadingView showInView:view];
}

+ (void)hideLoadingForView:(UIView *)view{
    ZJLoadingView *loadingView = [self loadingForView:view];
    if (loadingView) {
        [loadingView hide];
    }
}

+ (void)hideAllLoadingForView:(UIView *)view{
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            [(ZJLoadingView *)subview hideNoAnimation];
        }
    }
}

+ (ZJLoadingView *)loadingForView:(UIView *)view{
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            return (ZJLoadingView *)subview;
        }
    }
    return nil;
}

#pragma mark - 实例方法
- (void)showInView:(UIView *)view{
    if (!view) {
        return ;
    }
    if (self.superview != view) {
        [self removeFromSuperview];
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }
    [self.imageView startAnimating];
}

- (void)hide{
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self hideNoAnimation];
    }];
}

- (void)hideNoAnimation{
    [self.imageView stopAnimating];
    [self removeFromSuperview];
}


- (void)dealloc{
    NSLog(@"%@释放了",[self class]);
}
@end
