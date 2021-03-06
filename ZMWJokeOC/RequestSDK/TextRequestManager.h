//
//  TextRequestManager.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "RequestBaseManager.h"

@interface TextRequestManager : RequestBaseManager

#define kContentUrl             @"https://japi.juhe.cn/joke/content/text.from"  // 文字
#define kContentUrl_Collection  @"https://japi.juhe.cn/joke/content/text.from_Collection"  // 收藏的文字


/**
 *  @brief  请求文字
 *
 *  @param  currentPage   当前页数
 *  @param  response block
 */
+ (void)getTextWithPage:(int)currentPage response:(RequestResponseBlock)response;

@end
