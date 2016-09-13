//
//  EmptyView.h
//  Vodka
//
//  Created by xiaoming on 15/11/30.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyView : UIView

/// 默认图。
@property (nonatomic, strong) UIImageView *imageV;
/// 默认文字。
@property (nonatomic, strong) UILabel *label;

/**
 * 默认的背景、字体大小和颜色都是项目中常用的 。如果有特殊效果，单独调用上面的两个属性设置就可以了。
 *
 *  @param image      图片
 *  @param labelTitle 文字
 */
- (void)image:(UIImage *)image labelTitle:(NSString *)labelTitle;

@end
