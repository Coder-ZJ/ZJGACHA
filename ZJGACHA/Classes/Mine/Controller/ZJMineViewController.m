//
//  ZJMineViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJMineViewController.h"

@interface ZJMineViewController ()

@end

@implementation ZJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavView];
}

- (void)setupNavView
{
    [super setupNavView];
    self.navView.backgroundColor = [ZJColor clearColor];
    [self.navView.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.navView.showBottomLine = NO;
    self.navView.rightButtonBlock = ^{
        
    };
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
