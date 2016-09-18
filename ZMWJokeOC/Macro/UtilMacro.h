//
//  UtilMacro.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

/**
 *  @brief 输出格式如下的打印信息：(类名:行数   打印的信息), 只有在DEBUG模式下输出，release模式不会输出(Build Settings 中 Preprocessor Macros 的 Debug 后边会有 DEBUG = 1 定义)
 */

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%d \t %s \n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#pragma mark - 字体
// Helvetica
#define FONT_Helvetica(F)                  [UIFont fontWithName: @"Helvetica" size: F]
// Helvetica-LIGHT
#define FONT_Helvetica_LIGHT(F)            [UIFont fontWithName: @"Helvetica-light" size: F]
// Helvetica
#define FONT_Helvetica_BOLD(F)             [UIFont fontWithName: @"Helvetica-bold" size: F]

#define FONT_NUMBER_BEBAS_NEUE(fontSize)   [UIFont fontWithName: @"BebasNeue" size: fontSize]

#pragma mark - 单例化一个类 instanceMethod:单例的方法名称

#define instance_interface(className, instanceMethod)   \
\
+ (instancetype)instanceMethod;

//实现方法
#define instance_implementation(className, instanceMethod)   \
\
static className * _instance; \
\
+ (instancetype)instanceMethod \
{   static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc]init]; \
}); \
return _instance; \
} \
\
+ (id)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return _instance; \
}

#pragma mark - 设备判断

#define IS_IPHONE4                          (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE5                          (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE6                          (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < DBL_EPSILON)

#define IS_IPHONE6_PLUS                     (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < DBL_EPSILON)

#pragma mark - 颜色定义

// 页面默认背景色、tablView的背景色
#define kSpeedX_Color_View_Color_Bg         [UIColor colorFromHexString:@"0XFFFFFF"]

// 页面中TableView的分割线颜色
#define kSpeedX_Color_Table_Seperator_Line  [UIColor colorFromHexString:@"0XEEEEEE"]

// TableView的cell默认颜色值、
#define kSpeedX_Color_Table_Cell_Default_Bg [UIColor colorFromHexString:@"0xFFFFFF"]

// 导航栏、tabbar
#define kSpeedX_Color_Navigation_Bg         [UIColor colorFromHexString:@"0XFFFFFF"]

// 黑色字体颜色
#define kSpeedX_Color_Black_Font            [UIColor colorFromHexString:@"0X111111"]

// 黑色字体颜色
#define kSPEEDX_COLOR_TOMATO                [UIColor colorFromHexString:@"0XD62424"]



#endif /* UtilMacro_h */
