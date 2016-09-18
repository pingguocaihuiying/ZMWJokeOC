//
//  SizeMacro.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#ifndef SizeMacro_h
#define SizeMacro_h


#define SCREEN_WIDTH                       ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                      ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE                       ([UIScreen mainScreen].scale)

#define NAVIGATIONBAR_HEIGHT 64.0

#define TABBAR_HEIGHT   49.0

// App 版本号.
#define APP_VERSION                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// App构建版本号
#define APP_BUILD_VERSION                  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define SYSTEM_VERSION_STRING              [[UIDevice currentDevice] systemVersion]
#define SYSTEM_VERSION_FLOAT               [[[UIDevice currentDevice] systemVersion] floatValue]

#endif /* SizeMacro_h */
