//
//  ZJDiscoverRankViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/19.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverRankViewController.h"
#import "ZJDiscoverRankView.h"
#import "SPPageMenu.h"

@interface ZJDiscoverRankViewController ()<SPPageMenuDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) NSMutableArray *rankChildViewControllers;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZJDiscoverRankViewController

#pragma mark -----------------lazy-----------------
- (NSMutableArray *)rankChildViewControllers
{
    if (!_rankChildViewControllers) {
        _rankChildViewControllers = [[NSMutableArray alloc] init];
    }
    return _rankChildViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupUI];
}

- (void)setupNavView
{
    [super setupNavView];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"排行榜" forState:UIControlStateNormal];
}

- (void)setupUI
{
    self.titleArray = @[@"日榜",@"周榜",@"月榜"];
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64 + KStatusBarHeight, kScreenWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor =   [ZJColor blackColor];
    pageMenu.unSelectedItemTitleColor = [ZJColor appSupportColor];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.titleArray selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    self.pageMenu = pageMenu;

    for (int i = 0; i < self.titleArray.count; i++) {
        [self.rankChildViewControllers addObject:@1];
    }

    //滚动容器
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH + pageMenuH, kScreenWidth, kScreenHeight - NaviH - pageMenuH)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
    self.scrollView = scrollView;
    //这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    scrollView.contentSize = CGSizeMake(self.titleArray.count * kScreenWidth, 0);
    scrollView.contentOffset = CGPointMake(self.pageMenu.selectedItemIndex * kScreenWidth, 0);
    //pageMenu.selectedItemIndex就是选中的item下标 选中下标
    [self setupView:self.pageMenu.selectedItemIndex];
}

#pragma mark -----------------SPPageMenuDelegate-----------------
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    //如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    }else{
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    }
    if (self.rankChildViewControllers.count <= toIndex) {
        return;
    }
    //根据索引获取视图
    [self setupView:toIndex];
}

//初始化视图
- (void)setupView:(NSInteger )index
{
    id view = [self.rankChildViewControllers safeObjectAtIndex:index];
    if ([view isKindOfClass:[UIView class]]) {
        return;
    }
    switch (index) {
        case 0:
        {
            ZJDiscoverRankView *dayRankView = [[ZJDiscoverRankView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            dayRankView.type = trendTypeDay;
            [self.scrollView addSubview:dayRankView];
            //将当前视图添加到数组
            [self.rankChildViewControllers replaceObjectAtIndex:index withObject:dayRankView];
        }
            break;
        case 1:
        {
            ZJDiscoverRankView *weekRankView = [[ZJDiscoverRankView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            weekRankView.type = trendTypeWeek;
            [self.scrollView addSubview:weekRankView];
            //将当前视图添加到数组
            [self.rankChildViewControllers replaceObjectAtIndex:index withObject:weekRankView];
        }
            break;
        case 2:
        {
            ZJDiscoverRankView *monthRankView = [[ZJDiscoverRankView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            monthRankView.type = trendTypeMonth;
            [self.scrollView addSubview:monthRankView];
            //将当前视图添加到数组
            [self.rankChildViewControllers replaceObjectAtIndex:index withObject:monthRankView];
        }
            break;
        default:
            break;
    }
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
