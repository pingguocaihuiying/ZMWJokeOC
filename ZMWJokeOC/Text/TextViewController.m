//
//  TextViewController.m
//  ZMWJokeOC
//
//  Created by xiaoming on 16/9/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "TextViewController.h"
#import <Masonry.h>
#import "TextCell.h"
#import "TextRequestManager.h"

@interface TextViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;

@property (nonatomic, assign) int               currentPage;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文字";
    self.dataArray = [NSMutableArray array];
    // 初始化表格
    [self initTableView];

    [self requestAction];
    
}

#pragma mark - 下拉刷新
- (void)requestAction {
    
    self.currentPage = 1;
    [TextRequestManager getTextWithPage:self.currentPage response:^(BOOL successed, NSInteger code, NSString *responseString) {
        
    }];
}

#pragma mark - 初始化表格
- (void)initTableView {
    __weak typeof(self) wSelf = self;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor colorFromHexString:@"0xEEEEEE"];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:_tableView];
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wSelf.view).with.insets(UIEdgeInsetsMake(NAVIGATIONBAR_HEIGHT, 0, TABBAR_HEIGHT, 0));
    }];
    // 注册cell
    [_tableView registerClass:[TextCell class] forCellReuseIdentifier:@"TextCell"];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
    
    [cell updateCellWithString:@"测试数据" indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
