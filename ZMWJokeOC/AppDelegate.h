//
//  AppDelegate.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/13.
//  Copyright © 2016年 speedx. All rights reserved.
//

/*
    修改第三方的标记： todo-zhangmingwei
 
 
 
 */
#import <UIKit/UIKit.h>
#import "LLLoginViewController.h"   // 登录页面


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) LLLoginViewController *loginViewController;

- (void)showRootControllerForLoginStatus:(BOOL)successed;

@end

