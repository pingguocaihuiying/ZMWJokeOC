//
//  AvatarImageBrowser.h
//  Vodka
//
//  Created by xiaoming on 14-9-30.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IOSUtilsConfig.h"

@interface BigImageBrowser : NSObject

instance_interface(BigImageBrowser, defaultManager)

/// 大图的 imageView
@property (strong, nonatomic) UIImageView       *bigImageView;

/**
 *  点击 展示 大图
 *
 *  @param smallImageView 小图的 imageView
 *  @param superView       小图的 父视图  传入 self.view 有导航条，self.view.window 全屏
 */
- (void)showImage:(UIImageView *)smallImageView superView:(UIView*)superView;

@end
