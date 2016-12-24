//
//  WUserStatistics.h
//  ZMWJokeOC
//
//  Created by xiaoming on 16/12/24.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WUserStatistics : NSObject

/**
 *  初始化配置，一般在launchWithOption中调用
 */
+ (void)configure;

+ (void)enterPageViewWithPageID:(NSString *)pageID;

+ (void)leavePageViewWithPageID:(NSString *)pageID;

+ (void)sendEventToServer:(NSString *)eventId;

@end
