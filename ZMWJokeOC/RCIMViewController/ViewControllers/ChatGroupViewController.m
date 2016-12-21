//
//  ChatGroupViewController.m
//  Vodka
//
//  Created by jinyu on 16/7/11.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "ChatGroupViewController.h"
//#import "PushManager.h"
//#import "PersonalRootViewController.h"
//#import "UserManager.h"
#import "ReactiveCocoa.h"
//#import "RootViewController.h"
//#import "ClubGroupSettingViewController.h"
//#import "FriendsRequestManager.h"
//#import "Tools.h"
//#import "WebViewViewController.h"
#import "Tooles.h"

@interface ChatGroupViewController () {
    UIButton *button;
}

@end

@implementation ChatGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (![UserConfigureManager objectForKey:[NSString stringWithFormat:@"club_group_nickname_%@", self.targetId]]) {
//        [UserConfigureManager setObject:@YES forKey:[NSString stringWithFormat:@"club_group_nickname_%@", self.targetId]];
//    }
    
    [[RCIM sharedRCIM] setGlobalMessageAvatarStyle:RC_USER_AVATAR_CYCLE];

    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 85, 44)];
    [rightButton setImage:[UIImage imageNamed:@"club_group_setting_icon"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"club_group_setting_icon"] forState:UIControlStateHighlighted];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -35;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    __weak typeof(self) wSelf = self;
//    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
//        NSLog(@"进入群聊设置");
//        ClubGroupSettingViewController *groupSetting = [[ClubGroupSettingViewController alloc]                                                                      initWithClubId:self.targetId
//                                                                                                                                                                             block:^(BOOL showNickname) {
//                                                                                                                                                                                 wSelf.displayUserNameInCell = showNickname;
//                                                                                                                                                                                 
//                                                                                                                                                                                 [[RCIM sharedRCIM] setGroupInfoDataSource:self];
//                                                                                                                                                                                 [wSelf.conversationMessageCollectionView reloadData];
//                                                                                                                                                                                 [self.conversationMessageCollectionView reloadInputViews];
//                                                                                                                                                                             }];
//        groupSetting.clubObject = wSelf.clubObject;
//        [self.navigationController
//         pushViewController:groupSetting
//         animated:YES];
//    }];
//    [ClubRequestManager getClubGroupRemakr:self.targetId
//                                    userId:[[[UserManager ShareInstance] userModel] userid]
//                                completion:^(BOOL successed, NSInteger code, NSString *responseString) {
//                                    if (successed) {
//                                        NSDictionary *dict = [responseString jsonvalue];
//                                        NSDictionary *remarksDict = @{ @"club_id": wSelf.targetId, @"remarks": SAFE_GET_STRING(dict, @"clubChatNick") };
//                                        [UserManager ShareInstance].userModel.remarksForClub = remarksDict;
//                                        
//                                        [wSelf getGroupInfoWithGroupId:wSelf.targetId
//                                                            completion:^(RCGroup *groupInfo) {
//                                                                [[RCIM sharedRCIM] setGroupInfoDataSource:wSelf];
//                                                            }];
//                                    } else {
//                                        NSLog(@"%@", responseString);
//                                    }
//                                }];
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"received_rongcloud_message" object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        wSelf.strangerUserInfo = ((RCMessage *)[[(NSNotification *)x userInfo] objectForKey:@"message"]).content.senderUserInfo;
        [wSelf               getUserInfoWithUserId:wSelf.strangerUserInfo.userId
                                        completion:^(RCUserInfo *userInfo) {
                                            [[RCIM sharedRCIM] setUserInfoDataSource:wSelf];
                                        }];
    }];
    
//    [self getUserInfoWithUserId:[UserManager defaultManager].userModel.userId
//                     completion:^(RCUserInfo *userInfo) {
//                         [[RCIM sharedRCIM] setUserInfoDataSource:wSelf];
//                     }];
    
//    id isShowId = [UserConfigureManager objectForKey:[NSString stringWithFormat:@"club_group_nickname_%@", self.clubObject.clubID]];
    BOOL isShow = NO;
//    if (isShowId) {
//        isShow = [isShowId boolValue];
//    }
    self.displayUserNameInCell = isShow;// 是否显示用户的昵称
    [self.chatSessionInputBarControl.pluginBoardView removeItemWithTag:VOIP];
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion {
//    [ClubRequestManager requestClubDetailWithClubIdentifier:groupId
//                                                 completion:^(BOOL successed, NSInteger code, NSString *responseString) {
//                                                     if (successed) {
//                                                         ClubObjectModel *object = [[ClubObjectModel alloc] init];
//                                                         [object initWithDictionary:[responseString jsonvalue]];
//                                                         RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId
//                                                                                                 groupName:object.clubName
//                                                                                               portraitUri:object.clubLogoUrl];
//                                                         completion(group);
//                                                     }
//                                                 }];
}

/**
 * 此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion {
//    if ([userId isEqualToString:[UserManager defaultManager].userModel.userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc]init];
//        user.userId = [UserManager defaultManager].userModel.userId;
//        user.name = [UserManager ShareInstance].userModel.nickname;
//        
//        if (self.conversationType == ConversationType_GROUP) {
//            NSDictionary *dict = [UserManager ShareInstance].userModel.remarksForClub;
//            
//            if ([self.targetId isEqualToString:[dict objectForKey:@"club_id"]]) {
//                if (![NSString isEmptyString:[dict objectForKey:@"remarks"]]) {
//                    user.name = [dict objectForKey:@"remarks"];
//                }
//            }
//        }
//        
//        user.portraitUri = [UserManager ShareInstance].userModel.userAvatar;
//        
//        [RCIM sharedRCIM].currentUserInfo = user;
//        completion(user);
//    } else {
//        if ([userId isEqualToString:self.strangerUserInfo.userId]) {
//            if ([NSString isEmptyString:self.strangerUserInfo.portraitUri]) {
//                NSMutableDictionary *strangerUserInfoDict = [NSMutableDictionary dictionary];
//                [Tools getFileFromLoc:@"strangerUserInfoDict" into:strangerUserInfoDict];
//                
//                if (![NSString isEmptyString:[strangerUserInfoDict objectForKey:self.strangerUserInfo.userId]]) {
//                    self.strangerUserInfo.portraitUri = [strangerUserInfoDict objectForKey:self.strangerUserInfo.userId];
//                    completion(self.strangerUserInfo);
//                } else {
//                    /// 获取对方的头像
//                    [FriendsRequestManager getChatInfoByIds:self.strangerUserInfo.userId
//                                                   complete:^(BOOL successed, NSInteger code, NSString *responseString) {
//                                                       if (successed && [responseString jsonvalue]) {
//                                                           NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseString jsonvalue]];
//                                                           self.strangerUserInfo.portraitUri = SAFE_GET_STRING(dict[self.strangerUserInfo.userId], @"avatar");
//                                                           
//                                                           if (self.strangerUserInfo.portraitUri) {
//                                                               [strangerUserInfoDict setObject:self.strangerUserInfo.portraitUri
//                                                                                        forKey:self.strangerUserInfo.userId];
//                                                               [Tools saveFileToLoc:@"strangerUserInfoDict"
//                                                                             theFile:strangerUserInfoDict];
//                                                           }
//                                                       }
//                                                       
//                                                       completion(self.strangerUserInfo);
//                                                   }];
//                }
//            } else {
//                completion(self.strangerUserInfo);
//            }
//        }
//    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMessageCell *cell = (RCMessageCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    id isShowId = [UserConfigureManager objectForKey:[NSString stringWithFormat:@"club_group_nickname_%@", self.clubObject.clubID]];
//    BOOL isShow = NO;
//    if (isShowId) {
//        isShow = [isShowId boolValue];
//    }
//    self.displayUserNameInCell = isShow;// 是否显示用户的昵称
    return cell;
}

#pragma mark 点击url 跳转web
- (void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model {
//    WebViewViewController *vc = [[WebViewViewController alloc]initWithUrl:url];
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
