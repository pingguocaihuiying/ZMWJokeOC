//
//  PictureRequestManager.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/20.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "PictureRequestManager.h"

@implementation PictureRequestManager

/**
 *  @brief  请求图文
 *
 *  @param  currentPage   当前页数
 *  @param  response block
 */
+ (void)getPictureWithPage:(int)currentPage response:(RequestResponseBlock)response {
    NSString *urlString = [NSString stringWithFormat:@"%@", kPictureUrl];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@(currentPage) forKey:@"page"];
    [params setObject:@(20) forKey:@"pagesize"];
    [params setObject:kBaseRequestKey forKey:@"key"];
    
    [self createGetRequest:urlString params:params response:response];
}

@end
