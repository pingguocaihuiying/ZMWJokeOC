//
//  ChatBaseViewController.h
//  Vodka
//
//  Created by jinyu on 16/7/11.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
//#import "PushManager.h"
//#import "PersonalRootViewController.h"
//#import "UserManager.h"
#import "ReactiveCocoa.h"
//#import "RootViewController.h"
//#import "ClubGroupSettingViewController.h"
//#import "FriendsRequestManager.h"
#import "Tooles.h"
//#import "WebViewViewController.h"

#import "UtilMacro.h"

//RCConversationViewController有相应的宏定义。
typedef NS_ENUM (NSInteger, PLUGIN_BOARD_ITEM_TAG_TYPE) {
    ALBUM       =       1001,       ///相册
    CAMERA      =       1002,       ///拍照
    LOCATION    =       1003,       ///定位
    VOIP        =       1004,       ///语音通话
};
@interface ChatBaseViewController : RCConversationViewController<RCIMUserInfoDataSource>

@property (nonatomic, strong) RCUserInfo *strangerUserInfo;

@end
