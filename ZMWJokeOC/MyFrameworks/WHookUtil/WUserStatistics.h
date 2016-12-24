//
//  WUserStatistics.h
//  ZMWJokeOC
//
//  Created by xiaoming on 16/12/24.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WUserStatistics : NSObject

// 页面进入
+ (void)enterPageViewWithPageID:(NSString *)pageID;

// 页面离开
+ (void)leavePageViewWithPageID:(NSString *)pageID;

// 点击事件
+ (void)sendEventToServer:(NSString *)eventId;

@end
