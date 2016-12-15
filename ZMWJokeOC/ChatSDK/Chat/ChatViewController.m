//
//  ChatViewController.m
//  ZMWJokeOC
//
//  Created by zhangmingwei on 2016/12/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "ChatViewController.h"
// LLChat的
#import "LLConfig.h"
#import "LLMessageTextCell.h"
#import "LLMessageDateCell.h"
#import "LLMessageRecordingCell.h"
#import "LLChatInputView.h"
#import "LLChatManager.h"
#import "LLUtils.h"
#import "LLActionSheet.h"
#import "UIKit+LLExt.h"
#import "LLWebViewController.h"
#import "LLMessageImageCell.h"
#import "LLChatAssetDisplayController.h"
#import "LLImagePickerControllerDelegate.h"
#import "LLAssetManager.h"
#import "LLImagePickerController.h"
#import "LLMessageGifCell.h"
#import "LLGaoDeLocationViewController.h"
#import "LLMessageLocationCell.h"
#import "LLLocationShowController.h"
#import "LLAudioManager.h"
#import "LLMessageVoiceCell.h"
#import "LLMessageVideoCell.h"
#import "UIImagePickerController_L1.h"
#import "LLDeviceManager.h"
#import "LLChatVoiceTipView.h"
#import "LLMessageCellManager.h"
#import "LLChatMoreBottomBar.h"
#import "LLChatSharePanel.h"
#import "LLSightCapatureController.h"
#import "LLMessageCacheManager.h"
#import "LLConversationModelManager.h"
#import "LLGIFDisplayController.h"
#import "LLTextDisplayController.h"
#import "LLTextActionDelegate.h"
#import "LLUserProfile.h"
#import "MFMailComposeViewController_LL.h"
#import "LLNavigationController.h"

@import MediaPlayer;

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,
LLMessageCellActionDelegate, LLChatImagePreviewDelegate,
LLImagePickerControllerDelegate, LLChatShareDelegate, LLLocationViewDelegate,
LLAudioRecordDelegate, LLAudioPlayDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, LLChatManagerMessageListDelegate,
LLDeviceManagerDelegate, LLSightCapatureControllerDelegate, LLTextActionDelegate,
MFMailComposeViewControllerDelegate
>
{
    BOOL isPulling;
    BOOL isLoading;
}

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) LLChatInputView               *chatInputView;
@property (nonatomic, strong) LLChatVoiceTipView            *voiceTipView;
@property (nonatomic, strong) LLVoiceIndicatorView          *voiceIndicatorView;
@property (nonatomic, strong) LLChatMoreBottomBar           *chatMoreBottomBar;
@property (nonatomic, strong) LLChatSharePanel              *chatSharePanel;

@property (nonatomic, strong) UIView                        *refreshView;
@property (nonatomic, strong) UIImagePickerController_L1    *imagePicker;

@property (nonatomic, strong)  NSMutableArray<LLMessageModel *> *dataSource;
@property (nonatomic, strong)  NSMutableArray<LLMessageModel *> *selectedMessageModels;

@end

@implementation ChatViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.conversationModel.nickName;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initAllView];
    
}

- (void)initAllView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.refreshView = [[UIView alloc] init];
    self.refreshView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [self.view addSubview:self.refreshView];
    self.voiceTipView = [[LLChatVoiceTipView alloc] init];
    self.voiceTipView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 45);
    [self.view addSubview:self.voiceTipView];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.tableView addGestureRecognizer:tapGesture];
    
    self.chatInputView = [[LLChatInputView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, SCREEN_WIDTH, 50)];
    [self.view addSubview:self.chatInputView];
    self.chatInputView.delegate = self;
    self.dataSource = [NSMutableArray array];
    
    self.refreshView.backgroundColor = TABLEVIEW_BACKGROUND_COLOR;
    isPulling = NO;
    isLoading = NO;
    
}


@end
