//
//  AvatarImageBrowser.m
//  Vodka
//
//  Created by xiaoming on 14-9-30.
//  Copyright (c) 2014年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "BigImageBrowser.h"

static CGRect oldframe;

@interface BigImageBrowser ()

@end

@implementation BigImageBrowser

instance_implementation(BigImageBrowser, defaultManager)

/**
 *  点击 展示 大图
 *
 *  @param smallImageView 小图的 imageView
 *  @param superView       小图的 父视图  传入 self.view 有导航条，self.view.window 全屏
 */
- (void)showImage:(UIImageView *)smallImageView superView:(UIView*)superView{
    // 小图 image
    UIImage *smallImage = smallImageView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    // 背景View
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    // 原始小图的frame
    oldframe=[smallImageView convertRect:smallImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    self.bigImageView=[[UIImageView alloc]initWithFrame:oldframe];
    self.bigImageView.image = smallImage;
    self.bigImageView.tag = 1;
    [backgroundView addSubview:self.bigImageView];
    [superView addSubview:backgroundView];
    
    __weak typeof(self) wSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        wSelf.bigImageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-smallImage.size.height*[UIScreen mainScreen].bounds.size.width/smallImage.size.width)/2, [UIScreen mainScreen].bounds.size.width, smallImage.size.height*[UIScreen mainScreen].bounds.size.width/smallImage.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:wSelf action:@selector(hideImage:)];
        [backgroundView addGestureRecognizer: tap];
    }];
}

/**
 *  隐藏 大图
 *
 *  @param tap 点击 UITap
 */
-(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
