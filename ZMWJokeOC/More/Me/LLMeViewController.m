//
//  LLMeViewController.m
//  LLWeChat
//
//  Created by GYJZH on 9/8/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import "LLMeViewController.h"
#import "LLTableViewMeCell.h"
#import "LLUserProfile.h"
#import "LLTableViewCellData.h"
#import "LLMeSettingController.h"
#import "LLUtils.h"
#import "LLTableViewCell.h"

#import "UIColor+IOSUtils.h"
#import <Masonry.h>
#import "UtilMacro.h"

// 聊天相关
#import "LLConversationListController.h"
#import "LLChatViewController.h"

@interface LLMeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) NSArray<NSArray<LLTableViewCellData *> *> *dataSource;

@end

@implementation LLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    [self initTableView];
    NSArray<LLTableViewCellData *> *section1 = @[
            [[LLTableViewCellData alloc] initWithTitle:@"好友列表" iconName:@"MoreMyAlbum"],
            [[LLTableViewCellData alloc] initWithTitle:@"最近消息列表" iconName:@"MoreMyFavorites"],
            [[LLTableViewCellData alloc] initWithTitle:@"钱包" iconName:@"MoreMyBankCard"],
            [[LLTableViewCellData alloc] initWithTitle:@"卡包" iconName:@"MyCardPackageIcon"],
    ];
    
    NSArray<LLTableViewCellData *> *section2 = @[
            [[LLTableViewCellData alloc] initWithTitle:@"表情" iconName:@"MoreExpressionShops"],
    ];
    
    NSArray<LLTableViewCellData *> *section3 = @[
            [[LLTableViewCellData alloc] initWithTitle:@"退出" iconName:@"MoreSetting"],
    ];
    
    self.dataSource = @[section1, section2, section3];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, MAIN_BOTTOM_TABBAR_HEIGHT, 0);
}


- (void)initTableView {
    __weak typeof(self) wSelf = self;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor colorFromHexString:@"0xCCCCCC"];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:_tableView];
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wSelf.view).with.insets(UIEdgeInsetsMake(0, 0, TABBAR_HEIGHT, 0));
    }];
    // 注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - TableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else
        return self.dataSource[section-1].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 88;
    else
        return TABLE_VIEW_CELL_DEFAULT_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 15;
    else
        return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TABLE_SECTION_HEIGHT_ZERO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ID";
    static NSString *MeID = @"MeInfoCell";
    
    if (indexPath.section == 0) {
//        LLTableViewMeCell *cell = [tableView dequeueReusableCellWithIdentifier:MeID forIndexPath:indexPath];
//        UITableViewce *cell = [tableView dequeueReusableCellWithIdentifier:MeID forIndexPath:indexPath];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
//        cell.avatarImage.image = [UIImage imageNamed:[LLUserProfile myUserProfile].avatarURL];
//        cell.nickNameLabel.text = [LLUserProfile myUserProfile].nickName;
//        cell.WeChatIDLabel.text = [NSString stringWithFormat:@"微信号: %@", [LLUserProfile myUserProfile].userName];
        cell.imageView.image = [UIImage imageNamed:[LLUserProfile myUserProfile].avatarURL];
        cell.textLabel.text = [LLUserProfile myUserProfile].nickName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"微信号: %@", [LLUserProfile myUserProfile].userName];
        
        
        return cell;
    }else {
//        LLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        if (!cell) {
//            cell = [LLTableViewCell cellWithStyle:kLLTableViewCellStyleDefault reuseIdentifier:ID];
//        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        LLTableViewCellData *itemData = self.dataSource[indexPath.section-1][indexPath.row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = itemData.title;
        cell.imageView.image = itemData.icon;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) { // 好友列表
            LLConversationListController *vc = [[LLConversationListController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) { // 最近消息列表
            LLChatViewController *vc = [[LLChatViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 2) {
        
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) { // 退出登录
            [[LLClientManager sharedManager] logout];
        }
    }
}


@end
