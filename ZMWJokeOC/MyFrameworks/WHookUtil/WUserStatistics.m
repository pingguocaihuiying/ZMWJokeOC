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

#pragma mark -- 页面统计部分:进入页面
+ (void)enterPageViewWithPageID:(NSString *)pageID
{
    //进入页面
    [MobClick beginLogPageView:pageID];//("PageOne"为页面名称，可自定义)
}

#pragma mark -- 页面统计部分:离开页面
+ (void)leavePageViewWithPageID:(NSString *)pageID
{
    //离开页面
    [MobClick endLogPageView:pageID];
}


#pragma mark -- 自定义事件统计部分
+ (void)sendEventToServer:(NSString *)eventId
{
    //在这里发送event统计信息给服务端
    [MobClick event:eventId];
}

@end
