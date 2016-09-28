//
//  BaseViewController.h
//  Vodka
//
//  Created by Mark C.J. on 15-1-13.
//  Copyright (c) 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+IOSUtils.h"
#import "UIView+Utils.h"
#import "NSString+IOSUtils.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSString+IOSUtils.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
// 宏
#import "UtilMacro.h"
// 空视图.
#import "EmptyView.h"

@interface BaseViewController : UIViewController


/// 下个页面的返回按钮------（传空格就是只有一个箭头）
-(void)baseNextPageTitleButton:(NSString *)nextPageTitleString;

/**
 *  导航栏左边按钮  重写返回按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏左边按钮
 */
- (void)leftButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block;

/**
 *  导航栏右边按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block;

/**
 *  导航栏右边按钮 自己传入自定义的view 给右按钮
 *
 *  @param view        自定义按钮
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithView:(UIView *)view block:(void(^)(UIView *view))block;
/**
 *  导航栏右边按钮---靠右边的(点击事件小，在titleView太长的时候正好有个按钮和rightBtn太近的时候用的)
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithNameRight:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block;


@end
