//
//  AppDelegate.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/13.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "AppDelegate.h"
#import <WXTabBarController.h>
#import "TextViewController.h"
#import "PictureViewController.h"
#import "CollectionViewController.h"
#import "MoreViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController    *navigationController;
@property (nonatomic, strong) WXTabBarController        *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
        navigationController.navigationBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
        _navigationController = navigationController;
    }
    return _navigationController;
}

- (WXTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        WXTabBarController *tabBarController = [[WXTabBarController alloc] init];
        
        TextViewController *textVC = [[TextViewController alloc] init];
        textVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"文字" image:[UIImage imageNamed:@"home_normal"] selectedImage:[UIImage imageNamed:@"home_highlight"]];
        
        PictureViewController *pictureVC = [[PictureViewController alloc] init];
        pictureVC.title = @"图片";
        pictureVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"文字" image:[UIImage imageNamed:@"home_normal"] selectedImage:[UIImage imageNamed:@"home_highlight"]];
        
        CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
        collectionVC.title = @"文字";
        collectionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"文字" image:[UIImage imageNamed:@"home_normal"] selectedImage:[UIImage imageNamed:@"home_highlight"]];
        
        MoreViewController *moreVC = [[MoreViewController alloc] init];
        moreVC.title = @"文字";
        moreVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"文字" image:[UIImage imageNamed:@"home_normal"] selectedImage:[UIImage imageNamed:@"home_highlight"]];
        
        tabBarController.title = @"文字";
        tabBarController.tabBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
        tabBarController.viewControllers = @[
                                             [[UINavigationController alloc] initWithRootViewController:textVC],
                                             [[UINavigationController alloc] initWithRootViewController:pictureVC],
                                             [[UINavigationController alloc] initWithRootViewController:collectionVC],
                                             [[UINavigationController alloc] initWithRootViewController:moreVC],
                                             ];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
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
