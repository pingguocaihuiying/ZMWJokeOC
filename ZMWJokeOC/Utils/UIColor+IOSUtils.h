//
//  UIColor+IOSUtils.h
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (IOSUtils)

/**
 Creates a Color from a Hex representation string
 @param hexString   Hex string that looks like @"#FF0000" or @"FF0000"
 @return    Color
 */
+ (instancetype)colorFromHexString:(NSString *)hexString;

+ (instancetype)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 *  RGBA Helper method
 *
 *  @param red   红色的值 0 -- 255.0f
 *  @param green 绿色的值 0 -- 255.0f
 *  @param blue  蓝色的值 0 -- 255.0f
 *  @param alpha 透明度   0 -- 1.0f
 *
 *  @return UIColor
 */
+ (instancetype)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

@end
