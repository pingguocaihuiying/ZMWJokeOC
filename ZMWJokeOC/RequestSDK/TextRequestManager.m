//
//  TextRequestManager.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "TextRequestManager.h"

@implementation TextRequestManager

/**
 *  @brief  请求文字
 *
 *  @param  currentPage   当前页数
 *  @param  response block
 */
+ (void)getTextWithPage:(int)currentPage response:(RequestResponseBlock)response {
    NSString *urlString = [NSString stringWithFormat:@"%@", kContentUrl];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@(currentPage) forKey:@"page"];
    [params setObject:@(20) forKey:@"pagesize"];
    [params setObject:kBaseRequestKey forKey:@"key"];
    
    [self createRequest:urlString params:params response:response];
}

@end
