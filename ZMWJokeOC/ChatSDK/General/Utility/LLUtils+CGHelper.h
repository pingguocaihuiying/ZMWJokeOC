//
//  LLUtils+CGHelper.h
//  LLWeChat
//
//  Created by GYJZH on 9/10/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import "LLUtils.h"
#import "SizeMacro.h"   // SCREEN_WIDTH 重名了，所有导入自己的
@import ImageIO;


extern CGSize SCREEN_SIZE;

extern CGRect SCREEN_FRAME;
extern CGPoint SCREEN_CENTER;

OBJC_EXTERN CGFloat CGPointDistanceBetween(CGPoint point1, CGPoint point2);

@interface LLUtils (CGHelper)

+ (CGFloat)screenScale;

+ (CGRect)screenFrame;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)pixelAlignForFloat:(CGFloat)position;

+ (CGPoint)pixelAlignForPoint:(CGPoint)point;

+ (CGSize)convertPointSizeToPixelSize:(CGSize)pointSize;

+ (CALayer *)lineWithLength:(CGFloat)length atPoint:(CGPoint)point;

+ (UIColor *)colorAtPoint:(CGPoint)point fromImageView:(UIImageView *)imageView;

+ (CGSize)GIFDimensionalSize:(CGImageSourceRef)imgSourceRef;

@end
