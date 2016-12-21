//
//  SpeedxMessageRootViewController.m
//  Vodka
//
//  Created by jinyu on 16/6/27.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "SpeedxMessageRootViewController.h"
#import "ChatPriveateViewController.h"
#import "ChatGroupViewController.h"
#import "SpeedxAssistantViewController.h"
//#import "FeedbackRootViewController.h"
//#import "PersonalRootViewController.h"
//#import "ClubRootViewController.h"
//#import "PushManager.h"
#import <objc/runtime.h>

#import "UtilMacro.h"
#import "UserManager.h"

@interface SpeedxMessageRootViewController ()<RCIMGroupInfoDataSource, RCIMUserInfoDataSource>

@end

@implementation SpeedxMessageRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowNetworkIndicatorView = NO;
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    self.conversationListTableView.separatorColor = [UIColor colorFromHexString:@"E6E6E6"];
    self.conversationListTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PUBLICSERVICE targetId:RONG_CLOUD_PUBLIC_SERVICE_FEEDBACK isTop:YES];
    [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PUBLICSERVICE targetId:RONG_CLOUD_PUBLIC_SERVICE_SPEEDX_HELPER isTop:YES];
    
    self.topCellBackgroundColor = [UIColor whiteColor];
    self.conversationListTableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [cell.contentView viewWithTag:123990];
    
    [view removeFromSuperview];
    
    if (cell.model.conversationType != ConversationType_PUBLICSERVICE) {
        return;
    }
    
    UIView *titleView = cell.contentView.subviews[1];
    UIImageView *imageView = nil;
    UIImage *image = nil;
    
    if ([RONG_CLOUD_PUBLIC_SERVICE_FEEDBACK isEqualToString:PUBLIC_SERVICE_FEEDBACK_ZH]) {
        image = [UIImage imageNamed:@"feed_back_speedx_guanfang_zh_icon"];
    } else {
        image = [UIImage imageNamed:@"feed_back_speedx_guanfang_en_icon"];
    }
    
    RCConversationModel *model = self.conversationListDataSource[indexPath.item];
    NSString *title = model.conversationTitle;
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(self.view.width, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [(UILabel *)titleView font] } context:nil].size;
    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.tag = 123990;
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(image.size);
        make.left.equalTo(cell.contentView.mas_left).with.offset(68 + size.width + 8);
        make.centerY.mas_equalTo(titleView.mas_centerY).with.offset(0);
    }];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    [self.conversationListTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE) {
        if ([model.targetId isEqualToString:RONG_CLOUD_PUBLIC_SERVICE_FEEDBACK]) {
//            FeedbackRootViewController *feedbackRootViewCongtroller = [[FeedbackRootViewController alloc] initWithConversationType:ConversationType_PUBLICSERVICE targetId:RONG_CLOUD_PUBLIC_SERVICE_FEEDBACK];
            uint count =  [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PUBLICSERVICE targetId:RONG_CLOUD_PUBLIC_SERVICE_FEEDBACK];
//            [[PushManager defaultManager] setTotal_unread_message:[[PushManager defaultManager] total_unread_message] - count];
//            feedbackRootViewCongtroller.title = NSLocalizedString(@"kPerson_feedback_assistant", nil);
//            [self.navigationController pushViewController:feedbackRootViewCongtroller animated:YES];
        } else if ([model.targetId isEqualToString:RONG_CLOUD_PUBLIC_SERVICE_SPEEDX_HELPER]) {
            SpeedxAssistantViewController *assistantViewController = [[SpeedxAssistantViewController alloc] initWithConversationType:ConversationType_PUBLICSERVICE targetId:RONG_CLOUD_PUBLIC_SERVICE_SPEEDX_HELPER];
            uint count =  [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PUBLICSERVICE targetId:RONG_CLOUD_PUBLIC_SERVICE_SPEEDX_HELPER];
//            [[PushManager defaultManager] setTotal_unread_message:[[PushManager defaultManager] total_unread_message] - count];
            assistantViewController.title = NSLocalizedString(@"kAll_speedx_help", nil);
            [self.navigationController pushViewController:assistantViewController animated:YES];
        }
    } else {
        if (model.conversationType == ConversationType_PRIVATE) {
            ChatPriveateViewController *private = [[ChatPriveateViewController alloc] initWithConversationType:model.conversationType targetId:model.targetId];
            uint count = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
//            [[PushManager defaultManager] setTotal_unread_message:[[PushManager defaultManager] total_unread_message] - count];
            private.title = model.conversationTitle;
            [self.navigationController pushViewController:private animated:YES];
        } else if (model.conversationType == ConversationType_GROUP) {
            ChatGroupViewController *group = [[ChatGroupViewController alloc] initWithConversationType:model.conversationType targetId:model.targetId];
            uint count = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_GROUP)]];
//            [[PushManager defaultManager] setTotal_unread_message:[[PushManager defaultManager] total_unread_message] - count];
//            [[PushManager defaultManager] setGroup_unread_message:[[PushManager defaultManager] group_unread_message] - count];
            group.title = model.conversationTitle;
            [self.navigationController pushViewController:group animated:YES];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0 || indexPath.item == 1) {
        return NO;
    }
    
    return [super tableView:tableView canEditRowAtIndexPath:indexPath];
}


- (void)didTapCellPortrait:(RCConversationModel *)model {
//    if (model.conversationType == ConversationType_PRIVATE) {
//        PersonalRootViewController *personalRootViewController = [[PersonalRootViewController alloc] initWithPersonalType:kFriendHomePage useid:model.targetId];
//        [self.navigationController pushViewController:personalRootViewController animated:YES];
//    } else if (model.conversationType == ConversationType_GROUP) {
//        ClubRootViewController *clubRootViewController = [[ClubRootViewController alloc] initWithClubId:model.targetId clubObject:nil];
//        clubRootViewController.isPushed = YES;
//        [self.navigationController pushViewController:clubRootViewController animated:YES];
//    }
}

#pragma mark - 设置聊天用户信息

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion {
    [self requesstUserInfoWithUserID:userId
                            response:^(NSString *user_id, NSString *remarks, NSString *nickname, NSString *userAvatar) {
                                if ([userId isEqualToString:user_id]) {
//                                    RCUserInfo *useInfo = [[RCUserInfo alloc] initWithUserId:user_id name:[UserManager getDisplayStringWithNickname:nickname remarks:remarks]portrait:userAvatar];
//                                    completion(useInfo);
                                }
                            }];
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion {
//    if ([groupId isEqualToString:[UserManager defaultManager].userModel.clubId]) {
//        RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId groupName:[UserManager ShareInstance].userModel.clubName portraitUri:[[NSUserDefaults standardUserDefaults]objectForKey:@"clubLogoUrl"]];
//        completion(group);
//    }
}

- (void)requesstUserInfoWithUserID:(NSString *)userId response:(void (^) (NSString *user_id, NSString *remarks, NSString *nickname, NSString *userAvatar))response {
//    [UserInfoRequestManager getUserInfoByUserID:userId
//                                       response:^(BOOL successed, NSInteger code, NSString *responseString) {
//                                           if (successed) {
//                                               UserModel *userModel = [[UserModel alloc] initWithModelDictionary:[responseString jsonvalue]];
//                                               response(userModel.userid, userModel.remark, userModel.nickname, userModel.userAvatar);
//                                           }
//                                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
