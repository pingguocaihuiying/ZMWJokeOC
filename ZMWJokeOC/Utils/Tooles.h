//
//  Tooles.h
//  Vodka
//
//  Created by xiaoming on 14-9-4.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TextModel.h"               // 文字、图片公用的model

@interface Tooles : NSObject

typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;

/// 获取带 image/title 的按钮 (左右排列) 排序方式
typedef enum {
    imageLeft_wholeCenter   =   0,      // 图片居左，整体居中
    imageLeft_wholeLeft     =   1,      // 图片居左，整体居左
    imageleft_wholeRight    =   2,      // 图片居左，整体居右
    imageRight_wholeCenter  =   3,      // 图片居右，整体居中
    imageRight_wholeLeft    =   4,      // 图片居右，整体居左
    imageRight_wholeRight   =   5,      // 图片居右，整体居右
    
}ButtonImageTitleType;

+ (BOOL)removeImageWithName:(NSString *)imageName;
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

///下面两个方法可以存储自定义的对象---TMCache就不行。
+ (BOOL)saveFileToLoc:(NSString *)fileName theFile:(id)file;
+ (BOOL)getFileFromLoc:(NSString *)filePath into:(id)dic;
+ (BOOL)removeLoc:(NSString *)fileName;//删除。
// 是否是自定义的model
+ (BOOL)saveFileToLoc:(NSString *)fileName theFile:(id)file isModel:(BOOL)isModel;
// 是否是自定义model
+ (BOOL)getFileFromLoc:(NSString *)filePath into:(id)file isModel:(BOOL)isModel;

//自定义对象的时候用的。
+ (NSData *)getDataFileFromLoc:(NSString *)filePath into:(id)file;
///获取pathForResource 本地的图片。代替 imageNamed 的方法。--------除非是cell 的重复很多的默认图用imageNamed 否则都不建议用。
///去除所有空格。
+ (NSString *)removeAllBlank:(NSString *)string;
///根据色值 获取渐变 UIImage
+ (UIImage *)getImageFromColors:(NSArray *)colors ByGradientType:(GradientType)gradientType frame:(CGRect)frame;

/**
 *  获取本地路径url 或者 网络url
 *
 *  @param folderName 文件夹名称  本地路径的时候用，否则传 nil
 *  @param fileName   文件名字 本地路径的时候用，否则传 nil
 *  @param urlString  网络urlString
 *
 *  @return NSURL（网络或者本地）
 */
+ (NSURL *)getURLWithFolderName:(NSString *)folderName fileName:(NSString *)fileName urlString:(NSString *)urlString;
///判断时区是否在中国
+ (BOOL)          isInChina;

/**
 *  textFild 限制字数的方法
 *
 *  @param maxTextLength 最大长度
 *  @param resultString  返回的textField.text 的值 可以传空
 *  @param textField     textField 对象
 *
 *  @return 输入后的结果字符串
 */
+ (NSString *)textFieldLimtWithMaxLength:(int)maxTextLength resultString:(NSString *)resultString textField:(UITextField *)textField;

/**
 *  textView 限制字数的方法
 *
 *  @param maxTextLength 最大长度
 *  @param resultString  返回的textView.text 的值 可以传空
 *  @param textView     textView 对象
 *
 *  @return 输入后的结果字符串
 */
+ (NSString *)textViewLimtWithMaxLength:(int)maxTextLength resultString:(NSString *)resultString textView:(UITextView *)textView;

/// 获取国家编号
+ (NSString *)    getCountryCode;
+ (NSString *)    getLanguageCode;
/// 获取国家编号的字典。
+ (NSDictionary *)countryCodeDict;

+ (NSString *)quKongGe:(NSString *)sender;
+ (NSString *)quKongGeAndEnder:(NSString *)sender;

/// 删除多余的SSDWindow   Tool 通用的方法  分享登录 卡死页面 用的
+ (void)          removeSSDWindowAction;

///  解码 url 字符串
+ (NSString *)URLDecodedString:(NSString *)stringURL;

/**
 *  设置statusBar颜色是否是白色的
 *
 *  @param isWhiteColor YES:白色、NO:黑色
 */
+ (void)setStatusBarTitleColorIsWhiteColor:(BOOL)isWhiteColor;

/**
 *  获取常用的 UILabel
 *
 *  @param font      UIFont
 *  @param alignment NSTextAlignment
 *  @param textColor UIColor
 *
 *  @return UILabel
 */
+ (UILabel *)getLabelWithFont:(UIFont *)font alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor;

/**
 *  获取常用的 UIButton
 *
 *  @param title      按钮文字
 *  @param titleColor 文字颜色
 *  @param font       字体
 *
 *  @return UIButton
 */
+ (UIButton *)getButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  获取常用的 UIImageView
 *
 *  @param cornerRadius 圆角大小 - 为0的时候没有圆角
 *
 *  @return UIImageView
 */
+ (UIImageView *)getImageViewWithCornerRadius:(float)cornerRadius;

/**
 *  获取带 image/title 的按钮 (左右排列)
 *
 *  @param image      image
 *  @param title      title
 *  @param titleColor 字体颜色
 *  @param aFont       font
 *  @param spacing    image和title的间隔
 *  @param type       排列方式
 *
 *  @return UIButton
 */
+ (UIButton *)getButtonImageTitleWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor spacing:(float)spacing alignmentType:(ButtonImageTitleType)type aFont:(UIFont *)aFont;

/**
 保存model到收藏列表
 
 @param textModel 需要收藏的model
 */
+ (void)saveOrRemoveToCollectionListWithModel:(TextModel *)textModel;

/**
 在本地收藏列表的model里面是否有当前model
 */
+ (BOOL)existCollectionListWithModel:(TextModel *)model;

// 数组是否包含model
+ (BOOL)isContainsObject:(TextModel *)model withArray:(NSMutableArray *)array;
// - 删除数组中的某个model
+ (void)removeObject:(TextModel *)model withArray:(NSMutableArray *)array;

@end
