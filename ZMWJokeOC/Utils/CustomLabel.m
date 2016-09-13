//
//  DJLabel.m
//  zhangmingwei
//
//  Created by 张 on 14-3-18.
//  Copyright (c) 2014年 zhangmingwei. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (id)initWithFrame:(CGRect)frame fontSize:(float)fontSize alignment:(NSTextAlignment)alignment textColor:(UIColor *)textColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.insets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        
        self.frame = frame;
        self.font = [UIFont systemFontOfSize:16];//默认是16
        if (fontSize > 0) {
            self.font = [UIFont systemFontOfSize:fontSize];
        }
        self.textAlignment = alignment;
        self.textColor = textColor;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = _insets;
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

-(UILabel *)updateWithText:(NSString *)text specialTextColor:(UIColor *)specialColor range:(NSRange)range {
    
    /// 特殊文字的颜色.
    NSDictionary *dict = @{ NSForegroundColorAttributeName:specialColor};
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:text];
    [attrString addAttributes:dict range:range];
    
    self.attributedText = attrString;
    
    return self;
}


@end
