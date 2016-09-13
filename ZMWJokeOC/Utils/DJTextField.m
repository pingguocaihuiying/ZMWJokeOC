//
//  UITextField+Hint.m
//  zhangmingwei
//
//  Created by Samwise Pan on 3/18/14.
//  Copyright (c) 2014 zhangmingwei. All rights reserved.
//

#import "DJTextField.h"

@implementation DJTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0f, 10.0f);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10.0f, 10.0f);
}


//- (void)drawTextInRect:(CGRect)rect
//{
//    UIEdgeInsets insets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
//    
//    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
//}


@end
