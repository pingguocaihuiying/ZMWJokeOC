//
//  ChatPriveateViewController.m
//  Vodka
//
//  Created by jinyu on 16/7/11.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "ChatPriveateViewController.h"
#import "UIColor+IOSUtils.h"
#import "UserManager.h"
#import "NSString+IOSUtils.h"

@interface ChatPriveateViewController () {
    UIButton *button;
}

@end

@implementation ChatPriveateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) wSelf = self;
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:VOIP];///去掉了语音通话
    [[RCIM sharedRCIM] setGlobalMessageAvatarStyle:RC_USER_AVATAR_CYCLE];

    self.conversationMessageCollectionView.backgroundColor = [UIColor colorFromHexString:@"EDEDED"];
    [self initializationBackButton];//自定义返回按钮.
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"received_rongcloud_message" object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        wSelf.strangerUserInfo = ((RCMessage *)[[(NSNotification *)x userInfo] objectForKey:@"message"]).content.senderUserInfo;
        [wSelf getUserInfoWithUserId:wSelf.strangerUserInfo.userId
                                        completion:^(RCUserInfo *userInfo) {
                                            [[RCIM sharedRCIM] setUserInfoDataSource:wSelf];
                                        }];
    }];
    
    [self getUserInfoWithUserId:[UserManager defaultManager].userModel.userId
                     completion:^(RCUserInfo *userInfo) {
                         [[RCIM sharedRCIM] setUserInfoDataSource:wSelf];
                     }];
}

- (void)initializationBackButton {
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 60, 44)];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:button];
}

#pragma mark - 返回按钮
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    [button removeFromSuperview];
}

- (void)didTapCellPortrait:(NSString *)userId {
    
    if ([userId isEqualToString:[UserManager defaultManager].userModel.userId]) {
        return;
    }
    
//    PersonalRootViewController *controller = [[PersonalRootViewController alloc] initWithPersonalType:kFriendHomePage useid:userId];
//    [self.navigationController pushViewController:controller animated:YES];
}

/**
 * 此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion {
    if ([userId isEqualToString:[UserManager defaultManager].userModel.userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = [UserManager defaultManager].userModel.userId;
        user.name = [UserManager defaultManager].userModel.userName;
        
        if (self.conversationType == ConversationType_GROUP) {
//            NSDictionary *dict = [UserManager defaultManager].userModel.remarksForClub;
//            
//            if ([self.targetId isEqualToString:[dict objectForKey:@"club_id"]]) {
//                if (![NSString isEmptyString:[dict objectForKey:@"remarks"]]) {
//                    user.name = [dict objectForKey:@"remarks"];
//                }
//            }
        }
        
//        user.portraitUri = [UserManager defaultManager].userModel.userAvatar;
        
        [RCIM sharedRCIM].currentUserInfo = user;
        completion(user);
    } else {
        if ([userId isEqualToString:self.strangerUserInfo.userId]) {
            if ([self.strangerUserInfo.portraitUri isEmptyString]) {
                NSMutableDictionary *strangerUserInfoDict = [NSMutableDictionary dictionary];
                [Tooles getFileFromLoc:@"strangerUserInfoDict" into:strangerUserInfoDict];
                
                if (![[strangerUserInfoDict objectForKey:self.strangerUserInfo.userId]isEmptyString]) {
                    self.strangerUserInfo.portraitUri = [strangerUserInfoDict objectForKey:self.strangerUserInfo.userId];
                    completion(self.strangerUserInfo);
                } else {
                    /// 获取对方的头像
                    __weak typeof(self) wSelf = self;
//                    [FriendsRequestManager getChatInfoByIds:self.strangerUserInfo.userId
//                                                   complete:^(BOOL successed, NSInteger code, NSString *responseString) {
//                                                       if (successed && [responseString jsonvalue]) {
//                                                           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseString jsonvalue]];
//                                                           wSelf.strangerUserInfo.portraitUri = SAFE_GET_STRING(dict[wSelf.strangerUserInfo.userId], @"avatar");
//                                                           
//                                                           if (wSelf.strangerUserInfo.portraitUri) {
//                                                               [strangerUserInfoDict setObject:self.strangerUserInfo.portraitUri
//                                                                                        forKey:wSelf.strangerUserInfo.userId];
//                                                               [Tools saveFileToLoc:@"strangerUserInfoDict"
//                                                                             theFile:strangerUserInfoDict];
//                                                           }
//                                                       }
//                                                       
//                                                       completion(wSelf.strangerUserInfo);
//                                                   }];
                }
            } else {
                completion(self.strangerUserInfo);
            }
        }
    }
}

#pragma mark 点击url 跳转web
- (void)didTapUrlInMessageCell:(NSString *)url
                         model:(RCMessageModel *)model {
//    WebViewViewController *vc = [[WebViewViewController alloc]initWithUrl:url];
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
