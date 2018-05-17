//
//  ZJPostDetailViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailViewController.h"
#import "ZJPostDetailView.h"

@interface ZJPostDetailViewController ()

@end

@implementation ZJPostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupMainView];
}

- (void)setupNavView
{
    [super setupNavView];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"postDetail_share_h~iphone"] forState:UIControlStateNormal];
}

- (void)setupMainView
{
    ZJPostDetailView *postDetailView = [[ZJPostDetailView alloc] initWithFrame:CGRectZero];
    [self.view insertSubview:postDetailView belowSubview:self.navView];
    [postDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navView.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-KTabBarHeight);
    }];
    [postDetailView.superview layoutIfNeeded];
    postDetailView.postId = self.postId;
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
