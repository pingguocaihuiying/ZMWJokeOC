//
//  WHookUtility.h
//  ZMWJokeOC
//
//  Created by xiaoming on 16/12/24.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHookUtility : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
