//
//  ChatPriveateViewController.h
//  Vodka
//
//  Created by jinyu on 16/7/11.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "ChatBaseViewController.h"

@interface ChatPriveateViewController : RCConversationViewController<RCIMUserInfoDataSource>

@property (nonatomic, strong) RCUserInfo *strangerUserInfo;


@end
