//
//  Tooles.h
//  Vodka
//
//  Created by 小明 on 15-12-26.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>         //各种方便的block封装
#import <Masonry.h>

@interface Tooles : NSObject

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

/**
 *  获取 UILabel 便利方法
 *
 *  @param frame     label frame
 *  @param fontSize  字体大小
 *  @param alignment 对齐方式
 *  @param textColor 字体颜色
 *
 *  @return UILabel
 */
+(UILabel *)getLabel:(CGRect)frame fontSize:(float)fontSize alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor;

/**
 *  获取UILabel - masonry方式
 *
 *  @param font      UIFont字体
 *  @param alignment 对齐方式
 *  @param textColor 字体颜色
 *
 *  @return UILabel
 */
+ (UILabel *) getLabelMasonryFont:(UIFont *)font alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor;

/**
 *  获取 UIButton 便利方法
 *
 *  @param frame      按钮frame
 *  @param title      按钮文字
 *  @param titleColor 文字颜色
 *  @param titleSize  字体大小
 *
 *  @return UIButton
 */
+(UIButton *)getButton:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(float)titleSize;

/**
 *  获取 UIImageView 便利方法
 *
 *  @param frame        图片frame
 *  @param cornerRadius 圆角大小 - 为0的时候没有圆角
 *
 *  @return UIImageView
 */
+(UIImageView *)getImageView:(CGRect)frame cornerRadius:(float)cornerRadius;

/**
 *  获取 带 image title 的按钮
 *
 *  @param frame      按钮大小
 *  @param title      按钮标题
 *  @param image      按钮图片
 *  @param titleColor 按钮字体颜色
 *  @param titleSize  按钮字体大小
 *  @param kSpacing   按钮字体和图片的间距
 *  @param type       图片和title的位置 ：0：图片左 整体居中 1：图片左 整体居左 2: 图片左 整体居右 ---- 3:图片右 整体居中 4：图片右 整体居左 5：图片右 整体居右
 *
 *  @return UIButton
 */
+(UIButton *)getButtonWithImageAndTitle:(CGRect)frame title:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)titleColor titleSize:(float)titleSize kSpacing:(float)kSpacing alignmentType:(int)type;

/// - 根据色值 获取渐变 UIImage
+ (UIImage*) getImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType frame:(CGRect)frame;

/**
 *  设置状态栏字体的颜色
 *
 *  @param color 色值
 */
+(void)setStatusBarTitleColor:(UIColor *)color;

@end
