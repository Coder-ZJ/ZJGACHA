//
//  ZJBaseViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController

- (ZJNavigationView *)navView
{
    if (!_navView) {
        _navView = [[ZJNavigationView alloc] init];
        _navView.backgroundColor = [ZJColor whiteColor];
        [self.view addSubview:_navView];
        [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(64 + KStatusBarHeight);
        }];
        [self.navView.superview layoutIfNeeded];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //禁止自动布局
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏自带的导航栏
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark -----------------加载自定义导航栏-----------------
- (void)setupNavView
{
    [self navView];
}

#pragma mark -----------------接收系统内存警告-----------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    /**
     *  YYWebImage 清除缓存
     */
    [[YYImageCache sharedCache].memoryCache removeAllObjects];

    /**
     *  UIWebView 清除缓存
     */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    /**
     *  SDWebImage 清除缓存
     */
    [[SDImageCache sharedImageCache] clearMemory];
}


@end
