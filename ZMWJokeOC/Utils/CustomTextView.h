//
//  BKTextView.h
//  Vodka
//
//  Created by xiaoming on 15/10/20.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView

///类似UITextField的默认的文字
@property (strong, nonatomic) NSString *placeholder;
///默认文字的颜色
@property (strong, nonatomic) UIColor *placeholderColor;
///默认文字的大小
@property (assign, nonatomic) float placeholerFontSize;

@end