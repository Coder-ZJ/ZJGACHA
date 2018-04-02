//
//  AppDelegate.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/2.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "AppDelegate.h"
#import "ZJTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ZJTabBarViewController *tabBar = [[ZJTabBarViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabBar;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {


}


- (void)applicationDidEnterBackground:(UIApplication *)application {


}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
