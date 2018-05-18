//
//  ZJDiscoverViewController.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverViewController.h"
#import "ZJDiscoverRecommendView.h"
#import "ZJDiscoverInsetView.h"
#import "ZJDiscoverArticleView.h"
#import "SPPageMenu.h"

@interface ZJDiscoverViewController ()<SPPageMenuDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *pageMenuTitles;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) ZJDiscoverRecommendView *recommendView;
@property (nonatomic, strong) ZJDiscoverInsetView *insetView;
@property (nonatomic, strong) ZJDiscoverArticleView *articleView;
@property (nonatomic, strong) ZJDiscoverInsetView *COSView;
@end

@implementation ZJDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavView];
    [self setupPageMenu];
}

- (void)setupNavView
{
    [super setupNavView];
    [self.navView.centerButton setTitle:@"发现" forState:UIControlStateNormal];
}

//初始化pageMenu
- (void)setupPageMenu
{
    self.pageMenuTitles = @[@"推荐",@"插画",@"文章",@"COS"];
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64 + KStatusBarHeight, kScreenWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor = [ZJColor blackColor];
    pageMenu.unSelectedItemTitleColor = [ZJColor appSupportColor];
    //传递数组，选中第一个
    [pageMenu setItems:self.pageMenuTitles selectedItemIndex:0];
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    self.pageMenu = pageMenu;

    for (int i = 0 ; i < self.pageMenuTitles.count; i++) {
        [self.myChildViewControllers addObject:@1];
    }

    //滚动容器
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH + pageMenuH, kScreenWidth, kScreenHeight - NaviH - pageMenuH - self.tabBarController.tabBar.height)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
    self.scrollView = scrollView;
    //这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    scrollView.contentSize = CGSizeMake(self.pageMenuTitles.count * kScreenWidth, 0);
    scrollView.contentOffset = CGPointMake(self.pageMenu.selectedItemIndex * kScreenWidth, 0);
    //pageMenu.selectedItemIndex就是选中的item下标 选中下标
    [self setupView:self.pageMenu.selectedItemIndex];
}

#pragma mark -----------------SPPageMenuDelegate-----------------
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    NSLog(@"%ld-----%ld",fromIndex,toIndex);
    //如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    }else{
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    }
    if (self.myChildViewControllers.count <= toIndex) {
        return;
    }
    //根据索引获取视图
    [self setupView:toIndex];
}
//初始化视图
- (void)setupView:(NSInteger)index
{

    id view = [self.childViewControllers safeObjectAtIndex:index];
    //避免重复创建视图
    if ([view isKindOfClass:[UIView class]]) {
        return;
    }
    switch (index) {
        case 0:
        {
            if (!_recommendView) {
                ZJDiscoverRecommendView *recommendView = [[ZJDiscoverRecommendView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
                [self.scrollView addSubview:recommendView];
                _recommendView = recommendView;
                //将当前视图存入数组
                [self.myChildViewControllers replaceObjectAtIndex:index withObject:recommendView];
            }
        }
            break;
        case 1:
        {
            if (!_insetView) {
                ZJDiscoverInsetView *insetView = [[ZJDiscoverInsetView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
                [self.scrollView addSubview:insetView];
                _insetView = insetView;
                insetView.pageType = pageViewTypeInset;
                //将当前视图存入数组
                [self.myChildViewControllers replaceObjectAtIndex:index withObject:insetView];
            }
        }
            break;
        case 2:
        {
            if (!_articleView) {
                ZJDiscoverArticleView *articleView = [[ZJDiscoverArticleView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
                [self.scrollView addSubview:articleView];
                _articleView = articleView;
                //将当前视图存入数组
                [self.myChildViewControllers replaceObjectAtIndex:index withObject:articleView];
            }
        }
            break;
        case 3:
        {
            if (!_COSView) {
                ZJDiscoverInsetView *insetView = [[ZJDiscoverInsetView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
                [self.scrollView addSubview:insetView];
                _COSView = insetView;
                insetView.pageType = pageViewTypeCos;
                //将当前视图存入数组
                
                [self.myChildViewControllers replaceObjectAtIndex:index withObject:insetView];
            }
        }
            break;

        default:
            break;
    }
}
#pragma mark -----------------lazy-----------------
- (NSMutableArray *)myChildViewControllers
{
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
