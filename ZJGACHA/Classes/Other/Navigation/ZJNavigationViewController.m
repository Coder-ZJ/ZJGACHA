//
//  ZJNavigationViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJNavigationViewController.h"

@interface ZJNavigationViewController ()

@end

@implementation ZJNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决手势失效
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;//隐藏二级页面的tabbar
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    //解决iPhone X push页面时 tabBar上移的问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
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
