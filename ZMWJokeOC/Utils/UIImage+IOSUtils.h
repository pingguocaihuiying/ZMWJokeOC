//
//  UIImage+IOSUtils.h
//  Toos
//
//  Created by xiaoming on 15/12/24.
//  Copyright © 2015年 shandandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IOSUtils)

typedef enum  {
    imageTopToBottom = 0,//从上到小
    imageLeftToRight = 1,//从左到右
    imageUpleftTolowRight = 2,//左上到右下
    imageUprightTolowLeft = 3,//右上到左下
}ImageGradientType;

/**
 *  获取pathForResource 本地的图片。代替 imageNamed 的方法。---除非是cell 的或者重复很多的默认图用imageNamed 否则都不建议用。
 *
 *  @param imageName 项目目录中的图片名字
 *
 *  @return UIImage
 */
+(UIImage *)getImageForResourceWithName:(NSString *)imageName;

/**
 *  @brief 生成圆角图片
 *
 *  @param image 要生成圆角的图片
 *  @param size  生成的图片大小
 *  @param r     圆角的大小
 *
 *  @return      生成的圆角图片
 */
+ (UIImage*)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

+ (UIImage*)scaleToSize:(CGSize)size image:(UIImage*)image;

/**
 *  @brief 生成截图
 *
 *  @param view  要截图的view
 *  @param size  要截取view上边图片的大小
 *
 *  @return      生成的截图
 */
+ (UIImage*)screenShot:(UIView *)view size:(CGSize)size resultImage:(void (^)(UIImage* image))resultImage;

///获取图片中某一点的颜色值
- (UIColor *)colorAtPixel:(CGPoint)point;

/**
 *  获取固定size的UIImage
 *
 *  @param image     原图片
 *  @param scaleSize 目标大小 float 类型的比例。
 *
 *  @return 新尺寸的图片
 */
+ (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 *  创建图片
 *
 *  @param view 传入view
 *
 *  @return 返回图片
 */
+(UIImage*)createImageFromView:(UIView*)view;
/**
 *  根据UIColor获取图片
 *
 *  @param color UIColor
 *  @param size  图片大小
 *
 *  @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  根据色值 获取渐变 UIImage
 *
 *  @param colors       UIColors的数组
 *  @param gradientType 方向
 *  @param frame        大小
 *
 *  @return UIImage
 */
+ (UIImage*) getImageFromColors:(NSArray*)colors ByGradientType:(ImageGradientType)gradientType frame:(CGRect)frame;

/**
 *  把横屏倒转过来 拍照的时候，经常横屏。
 *
 *  @param aImage 原始图片
 *
 *  @return 返回的图片
 */
- (UIImage *)fixOrientation:(UIImage *)aImage;


/**
 *  压缩图片到规定的大小
 *
 *  @param image 原图片
 *
 *  @param aSize 压缩的大小   50480  是 10k
 *
 *  @return 规定大小的图片
 */
+(UIImage *)compressImage:(UIImage *)image toSize:(float)aSize;

/**
 *  指定宽度。等比例缩放图
 *
 *  @param sourceImage 原始图片
 *  @param defineWidth 目标的宽度
 *
 *  @return 结果图片
 */
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 *  高性能设置UIImage圆角
 *
 *  @param sizeToFit 图片大小
 *  @param radius    圆角大小
 *
 *  @return UIImage
 */
- (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;

@end
