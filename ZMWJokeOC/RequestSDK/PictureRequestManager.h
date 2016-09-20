//
//  PictureRequestManager.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/20.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "RequestBaseManager.h"

@interface PictureRequestManager : RequestBaseManager

#define kPictureUrl       @"http://japi.juhe.cn/joke/img/text.from"


/**
 *  @brief  请求图文
 *
 *  @param  currentPage   当前页数
 *  @param  response block
 */
+ (void)getPictureWithPage:(int)currentPage response:(RequestResponseBlock)response;


@end
