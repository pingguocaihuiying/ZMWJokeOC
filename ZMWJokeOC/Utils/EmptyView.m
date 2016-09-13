//
//  EmptyView.m
//  Vodka
//
//  Created by xiaoming on 15/11/30.
//  Copyright © 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "EmptyView.h"
#import "UIView+Utils.h"
#import "UIColor+IOSUtils.h"

@interface EmptyView()

@end


@implementation EmptyView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //默认图。
        _imageV = [[UIImageView alloc]init];
        [self addSubview:_imageV];
        _imageV.frame = CGRectMake(0, 0, 65.5, 55.5);
        _imageV.center = CGPointMake(self.centerX, self.centerY - 50);
        _imageV.backgroundColor = [UIColor clearColor];
        
        //默认文字。
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        _label.backgroundColor = [UIColor clearColor];
        _label.frame = CGRectMake(20, 50, self.width - 20*2, 20);
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:16];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorFromHexString:@"#333333"];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/**
 * 默认的背景、字体大小和颜色都是项目中常用的 。如果有特殊效果，单独调用上面的两个属性设置就可以了。
 *
 *  @param image      图片
 *  @param labelTitle 文字
 */
- (void)image:(UIImage *)image labelTitle:(NSString *)labelTitle{
    self.imageV.image = image;
    self.label.text = labelTitle;
    [self.label sizeToFit];
    
    self.imageV.frame = CGRectMake(self.width/2.0f - image.size.width/2.0f, 80, image.size.width, image.size.height);
    self.label.frame = CGRectMake(20, self.imageV.bottom + 15, self.width - 20*2, self.label.height);

}


@end
