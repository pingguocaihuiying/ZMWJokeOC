//
//  ChatGroupViewController.h
//  Vodka
//
//  Created by jinyu on 16/7/11.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
//#import "ClubObjectModel.h"
#import "ChatBaseViewController.h"

@interface ChatGroupViewController : RCConversationViewController<RCIMGroupInfoDataSource, RCIMUserInfoDataSource>

@property (nonatomic, strong) RCUserInfo *strangerUserInfo;
//@property (nonatomic, strong) ClubObjectModel *clubObject;

@end
