//
//  WUserStatistics.m
//  ZMWJokeOC
//
//  Created by xiaoming on 16/12/24.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "WUserStatistics.h"

// umeng统计
#import "UMMobClick/MobClick.h"

@implementation WUserStatistics

/**
 *  初始化配置，一般在launchWithOption中调用
 */
+ (void)configure
{
    
}

#pragma mark -- 页面统计部分

+ (void)enterPageViewWithPageID:(NSString *)pageID
{
    //进入页面
    [MobClick beginLogPageView:pageID];//("PageOne"为页面名称，可自定义)

}

+ (void)leavePageViewWithPageID:(NSString *)pageID
{
    //离开页面
    [MobClick endLogPageView:pageID];
}


#pragma mark -- 自定义事件统计部分


+ (void)sendEventToServer:(NSString *)eventId
{
    //在这里发送event统计信息给服务端
    // NSLog(@"***模拟发送统计事件给服务端，事件ID: %@", eventId);
}

@end
