//
//  DJLabel.h
//  zhangmingwei
//
//  Created by 张 on 14-3-18.
//  Copyright (c) 2014年 zhangmingwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets insets;

- (id)initWithFrame:(CGRect)frame fontSize:(float)fontSize alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor;

-(UILabel *)updateWithText:(NSString *)text specialTextColor:(UIColor *)specialColor range:(NSRange)range ;

@end
