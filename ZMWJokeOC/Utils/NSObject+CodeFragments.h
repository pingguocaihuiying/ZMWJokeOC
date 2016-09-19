//
//  NSObject+CodeFragment.h
//  CodeFragment
//
//  Created by jinyu on 14/12/6.
//  Copyright (c) 2014年 jinyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileArguments : NSObject

@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *directory;
@property (nonatomic, strong) NSString *systemPath;
@property (nonatomic, assign) float scale;

@end

typedef void (^SaveImageComplete) (NSString *relativePath, NSString *absolutePath);

@interface NSObject (CodeFragments)

/**
 *  @brief  获取系统当前的语言
 *
 *  @return 当前语言字符串.  eg. en:英文  zh-Hans:简体中文
 */
+ (NSString *)currentSystemLanguage;

/**
 *  @brief 把图片保存到应用的沙盒中
 *
 *  @param image     要保存的图片
 *  @param arguments 保存时的参数
 *  @param complete  保存完成后的block，会包含图片的绝对路径(absolutePath)和相对路径(relativePath)
 */
- (void)      writeImage:(UIImage *)image withFileArguments:(FileArguments *)arguments complete:(SaveImageComplete)complete;

/**
 *  @brief 把数据保存到应用的沙盒中
 *
 *  @param data     要保存的图片
 *  @param arguments 保存时的参数
 *  @param complete  保存完成后的block，会包含图片的绝对路径(absolutePath)和相对路径(relativePath)
 */
- (void)writeData:(NSData *)data withFileArguments:(FileArguments *)arguments complete:(SaveImageComplete)complete;


/**
 *  @brief 根据相对路径得到沙盒的绝对路径
 *
 *  @param relativePath 相对路径
 *  @param systemPath   系统目录
 *
 *  @return             包含系统目录的绝对路径
 */
- (NSString *)absolutePath:(NSString *)relativePath systemPath:(NSString *)systemPath;

/**
 *  @brief  浮点数转整数（4舍5入）
 *
 *  @param  aFloatValue 浮点数
 *
 *  @return 转换后的整数
 */
- (NSInteger)integerWithFloat:(CGFloat)aFloatValue;


/*!
 @author 王金宇, 16-05-10 14:05:14
 
 @brief 在一个View中获取某个ViewController
 
 @param aView view
 
 @param aClassName : 要获取的ViewController类名称
 
 @return ViewController
 
 @since 3.0
 */
- (UIViewController *)getViewControllerForUIView:(UIView *)aView aViewControllerClass:(NSString *)aClassName;

/*!
 @author 王金宇, 16-05-10 14:05:23
 
 @brief 在一个ViewController中获取另一个ViewController类
 
 @param aViewController 当前UIViewController
 @param aClassName      要获取的ViewController类名称
 
 @return 获取到的viewController
 
 @since 3.0
 */
- (UIViewController *)getViewControllerForUIViewController:(UIViewController *)aViewController aViewControllerClass:(NSString *)aClassName;

@end
