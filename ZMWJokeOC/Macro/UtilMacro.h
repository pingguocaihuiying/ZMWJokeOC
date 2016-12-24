//
//  UtilMacro.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "SizeMacro.h"               // 尺寸相关宏
#import "PathMacro.h"               // 路径相关宏
#import "ApiMacro.h"                // 接口相关宏
#import "NotificationMacro.h"       // 通知相关宏
#import "ThridMacro.h"              // 第三方账号相关宏
#import "UserDefaultMacro.h"        // userDefault相关存储的宏

#import "WUserStatistics.h"         // 统计相关

#import "Tooles.h"                  // 工具类
#import "UIColor+IOSUtils.h"        // 颜色的
#import "NSString+IOSUtils.h"       // 字符串的
#import "UIView+Utils.h"            // view的类目
#import <Masonry.h>                 // 布局的
#import <ReactiveCocoa/ReactiveCocoa.h> // rac

#ifndef UtilMacro_h
#define UtilMacro_h

/**
 *  @brief 输出格式如下的打印信息：(类名:行数   打印的信息), 只有在DEBUG模式下输出，release模式不会输出(Build Settings 中 Preprocessor Macros 的 Debug 后边会有 DEBUG = 1 定义)
 */

#if DEBUG
///debug模式下-----------------Begin--------------------------
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
///release模式下---------------End--------------------------
#define NSLog(tmt, ...)
#endif

#define kAnimation_Time 0.3f
#define kDegrees_To_Radian(x) (M_PI * (x) / 180.0)
#define kRadian_To_Degrees(radian) (radian*180.0)/(M_PI)

/// -----------------------------字符串、Number 保护-------------------------BEGIN
#define kSafe_Get_String(presence, key) \
([presence objectForKey: key] != nil && [presence objectForKey: key] != [NSNull null]) && [[presence objectForKey: key] isKindOfClass:[NSString class]] && ![[presence objectForKey: key] isEqualToString:@"null"] && ![[presence objectForKey: key] isEqualToString:@"<null>"] ? [presence objectForKey: key] : @"" \

#define kSaft_Get_Number(presence, key)  \
([presence objectForKey: key] != nil && [presence objectForKey: key] != [NSNull null]) ? [presence objectForKey: key] : @0 \
/// -----------------------------字符串、Number 保护-------------------------END

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
