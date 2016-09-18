//
//  NSObject+CodeFragment.m
//  CodeFragment
//
//  Created by jinyu on 14/12/6.
//  Copyright (c) 2014年 jinyu. All rights reserved.
//


//它会输出文件名，和打印的具体行号



#import "NSObject+CodeFragments.h"

@implementation NSObject (CodeFragments)

/**
 *  @brief 获取当前系统语言版本
 *
 *  @return 当前系统语言版本
 */
+ (NSString *)currentSystemLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    return currentLanguage;
}

- (void)writeImage:(UIImage *)image withFileArguments:(FileArguments *)arguments complete:(SaveImageComplete)complete {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    [defaultManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", arguments.systemPath, arguments.directory] withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSString *directoryPath = [arguments.systemPath stringByAppendingPathComponent:arguments.directory];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:arguments.filename];
    NSData *data = UIImageJPEGRepresentation(image, arguments.scale);
    [data writeToFile:filePath atomically:YES];
    complete([NSString stringWithFormat:@"%@/%@", arguments.directory, arguments.filename], [NSString stringWithFormat:@"%@/%@/%@", arguments.systemPath, arguments.directory, arguments.filename]);
}

/**
 *  @brief 把数据保存到应用的沙盒中
 *
 *  @param image     要保存的图片
 *  @param arguments 保存时的参数
 *  @param complete  保存完成后的block，会包含图片的绝对路径(absolutePath)和相对路径(relativePath)
 */
- (void)writeData:(NSData *)data withFileArguments:(FileArguments *)arguments complete:(SaveImageComplete)complete {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    [defaultManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", arguments.systemPath, arguments.directory] withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSString *directoryPath = [arguments.systemPath stringByAppendingPathComponent:arguments.directory];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:arguments.filename];
    [data writeToFile:filePath atomically:YES];
    complete([NSString stringWithFormat:@"%@/%@", arguments.directory, arguments.filename], [NSString stringWithFormat:@"%@/%@/%@", arguments.systemPath, arguments.directory, arguments.filename]);
}

- (NSString *)absolutePath:(NSString *)relativePath systemPath:(NSString *)systemPath {
    return [systemPath stringByAppendingPathComponent:relativePath];
}

/**
 *  @brief  浮点数转整数（4舍5入）
 *
 *  @param  aFloatValue 浮点数
 *
 *  @return 转换后的整数
 */
- (NSInteger)integerWithFloat:(CGFloat)aFloatValue {
    NSInteger i = 0;
    
    if (aFloatValue > 0)      //正数
        i = (aFloatValue * 10 + 5) / 10;
    else if (aFloatValue < 0) //负数
        i = (aFloatValue * 10 - 5) / 10;
    else i = 0;
    
    return i;
}

/*!
 @author 王金宇, 16-05-10 14:05:14
 
 @brief 在一个View中获取某个ViewController
 
 @param aView view
 
 @param aClassName : 要获取的ViewController类名称
 
 @return ViewController
 
 @since 3.0
 */

- (UIViewController *)getViewControllerForUIView:(UIView *)aView aViewControllerClass:(NSString *)aClassName {
    for (UIView *next = [aView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:NSClassFromString(aClassName)]) {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

/*!
 @author 王金宇, 16-05-10 14:05:23
 
 @brief 在一个ViewController中获取另一个ViewController类
 
 @param aViewController 当前UIViewController
 @param aClassName      要获取的ViewController类名称
 
 @return 获取到的viewController
 
 @since 3.0
 */
- (UIViewController *)getViewControllerForUIViewController:(UIViewController *)aViewController aViewControllerClass:(NSString *)aClassName {
    for (UIView *next = [aViewController.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:NSClassFromString(aClassName)]) {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

@end

@implementation FileArguments


@end
