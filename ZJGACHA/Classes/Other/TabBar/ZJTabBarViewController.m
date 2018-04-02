//
//  ZJTabBarViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJTabBarViewController.h"
#import "ZJHomeViewController.h"
#import "ZJDiscoverViewController.h"
#import "ZJTopicViewController.h"
#import "ZJMessageViewController.h"
#import "ZJMineViewController.h"
#import "ZJNavigationViewController.h"


@interface ZJTabBarViewController ()

@end

@implementation ZJTabBarViewController

+ (void)initialize
{
    //未选中item的字体大小、颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];

    //选中item的字体大小、颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];

    //底部tabBar样式
    //[[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //[[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //[[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[ZMColor colorWithHexString:@"0xf5f5f5"]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addAllChildVC];

}
//添加所有子控制器
- (void)addAllChildVC
{
    //首页
    [self addChildVC:[[ZJHomeViewController alloc] init] title:@"首页" image:@"tabbar_icon0" selectedImage:@"tabbar_icon0_s"];

    //发现
    [self addChildVC:[[ZJDiscoverViewController alloc] init] title:@"发现" image:@"tabbar_icon1" selectedImage:@"tabbar_icon1_s"];

    //话题
    [self addChildVC:[[ZJTopicViewController alloc] init] title:@"话题" image:@"tabbar_icon2" selectedImage:@"tabbar_icon2_s"];

    //消息
    [self addChildVC:[[ZJMessageViewController alloc] init] title:@"消息" image:@"tabbar_icon_message" selectedImage:@"tabbar_icon_message_s"];

    //我的
    [self addChildVC:[[ZJMineViewController alloc] init] title:@"我的" image:@"tabbar_icon3" selectedImage:@"tabbar_icon3_s"];
}


/**
 添加子控制器

 @param vc 子控制器
 @param title 标题
 @param image 图片
 @param selectedImage 选中图片
 */
- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ZJNavigationViewController *nav = [[ZJNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
