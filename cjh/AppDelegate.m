//
//  AppDelegate.m
//  cjh
//
//  Created by yale on 15-7-10.
//  Copyright (c) 2015年 武汉亦鸟科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    WelcomeViewController *welcomeVC = [[WelcomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:welcomeVC];
    [nav.navigationBar setTintColor:[UIColor whiteColor]];
    [nav.navigationBar setBarTintColor:SYS_MAIN_COLOR_NORMAL];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //asdas测试一下撒       sds
    //asdas测试一下撒       sdsqweqw    //asdas测试一下撒       sds qweqwe
    
    
    //asdas测试一下撒       sds asdasasdasdasdasdas
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
