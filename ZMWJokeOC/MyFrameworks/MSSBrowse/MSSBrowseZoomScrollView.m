//
//  MSSBrowseZoomScrollView.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "MSSBrowseZoomScrollView.h"
#import "MSSBrowseDefine.h"

@interface MSSBrowseZoomScrollView ()

@property (nonatomic,copy)MSSBrowseZoomScrollViewTapBlock tapBlock;
@property (nonatomic,copy)MSSBrowseZoomScrollViewDoubleTapBlock doubleTapBlock;
@property (nonatomic,assign)BOOL isSingleTap;
@property (nonatomic, assign) BOOL  isDoubleTap;

@end

@implementation MSSBrowseZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createZoomScrollView];
    }
    return self;
}

- (void)createZoomScrollView
{
    self.delegate = self;
    _isSingleTap = NO;
    _isDoubleTap = NO;
    self.minimumZoomScale = 1.0f;
    self.maximumZoomScale = 8.0f;
    
    _zoomImageView = [[UIImageView alloc]init];
    _zoomImageView.userInteractionEnabled = YES;
    [self addSubview:_zoomImageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 延中心点缩放
    CGRect rect = _zoomImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.mssWidth) {
        rect.origin.x = floorf((self.mssWidth - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.mssHeight) {
        rect.origin.y = floorf((self.mssHeight - rect.size.height) / 2.0);
    }
    _zoomImageView.frame = rect;
}

- (void)tapClick:(MSSBrowseZoomScrollViewTapBlock)tapBlock
{
    _tapBlock = tapBlock;
}

- (void)doubleTapClick:(MSSBrowseZoomScrollViewDoubleTapBlock)doubleTapBlock {
    _doubleTapBlock = doubleTapBlock;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if(touch.tapCount == 2)
    {
        _isSingleTap = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(doubleTapClick) withObject:nil afterDelay:0.17];
    } else if (touch.tapCount == 1) {
        [self performSelector:@selector(singleTapClick) withObject:nil afterDelay:0.17];
    } else
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        // 防止先执行单击手势后还执行下面双击手势动画异常问题
        if(!_isSingleTap)
        {
            CGPoint touchPoint = [touch locationInView:_zoomImageView];
            [self zoomDoubleTapWithPoint:touchPoint];
        }
    }
}

- (void)singleTapClick
{
    _isSingleTap = YES;
    if(_tapBlock)
    {
        _tapBlock();
    }
}

- (void)doubleTapClick
{
    _isDoubleTap = YES;
    if(_doubleTapBlock)
    {
        _doubleTapBlock();
    }
}

- (void)zoomDoubleTapWithPoint:(CGPoint)touchPoint
{
    if(self.zoomScale > self.minimumZoomScale)
    {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
    else
    {
        CGFloat width = self.bounds.size.width / self.maximumZoomScale;
        CGFloat height = self.bounds.size.height / self.maximumZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - width / 2, touchPoint.y - height / 2, width, height) animated:YES];
    }
}


@end
