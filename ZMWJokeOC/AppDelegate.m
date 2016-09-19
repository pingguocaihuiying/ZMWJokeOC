//
//  AppDelegate.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/13.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "AppDelegate.h"
#import <XHTabBar.h>
#import "TextViewController.h"
#import "PictureViewController.h"
#import "CollectionViewController.h"
#import "MoreViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) XHTabBar                  *tabbar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 初始化自定义tabbar
    [self initTabbarAction];
    //设置为根控制器
    self.window.rootViewController = self.tabbar;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 初始化自定义tabbar
- (void) initTabbarAction {
    //控制器数组
    NSArray *controllerArray = @[@"TextViewController",@"PictureViewController",@"CollectionViewController",@"MoreViewController"];
    //title数组
    NSArray * titleArray = @[@"文字",@"图片",@"收藏",@"更多"];
    //默认图片数组
    NSArray *imageArray= @[@"home_normal",@"message_normal",@"home_normal",@"home_normal"];
    //选中图片数组
    NSArray *selImageArray = @[@"home_highlight",@"message_highlight",@"home_highlight",@"home_highlight"];
    //初始化(height:最小高度为49.0,当传nil 或<49.0时均按49.0处理)
    self.tabbar = [[XHTabBar alloc] initWithControllerArray:controllerArray titleArray:titleArray imageArray:imageArray selImageArray:selImageArray height:TABBAR_HEIGHT];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
