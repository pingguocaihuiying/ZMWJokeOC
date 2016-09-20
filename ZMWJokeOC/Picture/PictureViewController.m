//
//  PictureViewController.m
//  ZMWJokeOC
//
//  Created by xiaoming on 16/9/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "PictureViewController.h"
#import <Masonry.h>
#import "PictureCell.h"
#import "PictureRequestManager.h"
#import "TextModel.h"
#import <YYModel.h>
#import <MJRefresh.h>
#import "Tooles.h"

@interface PictureViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) NSMutableArray    *jsonArray;     // 保存本地用的

@property (nonatomic, assign) int               currentPage;
@property (nonatomic, strong) NSCache           *rowHeightCache;

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图文";
    self.dataArray = [NSMutableArray array];
    self.jsonArray = [NSMutableArray array];
    self.rowHeightCache = [[NSCache alloc] init];
    // 初始化表格
    [self initTableView];
    
    if (![self getLocalArray]) {
        [self requestAction];
    }
    
    __weak typeof(self) wSelf = self;
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [wSelf requestAction];
    }];
    // 加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [wSelf requestMoreAction];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - 获取本地缓存的数据
- (BOOL)getLocalArray {
    NSMutableArray *arr = [NSMutableArray array];
    if ([Tooles getFileFromLoc:kPictureUrl into:arr]) {
        self.dataArray = [NSMutableArray array];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dict = arr[i];
            TextModel *model = [[TextModel alloc] init];
            [model yy_modelSetWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        return YES;
    }
    return NO;
}

#pragma mark - 下拉刷新
- (void)requestAction {
    self.currentPage = 1;
    __weak typeof(self) wSelf = self;
    [PictureRequestManager getPictureWithPage:self.currentPage response:^(BOOL successed, NSInteger code, NSString *responseString) {
        [wSelf.tableView.mj_header endRefreshing];
        if (successed) {
            NSArray *resultArray = [[responseString jsonvalue] objectForKey:@"data"];
            if (resultArray && resultArray.count > 0) {
                wSelf.jsonArray = [NSMutableArray arrayWithArray:resultArray];
                [Tooles saveFileToLoc:kPictureUrl theFile:resultArray];
                wSelf.dataArray = [NSMutableArray array];
                for (int i = 0; i < resultArray.count; i++) {
                    NSDictionary *dict = resultArray[i];
                    TextModel *model = [[TextModel alloc] init];
                    [model yy_modelSetWithDictionary:dict];
                    [wSelf.dataArray addObject:model];
                }
            }
        }
        [wSelf.tableView reloadData];
    }];
}

#pragma mark - 加载更多
- (void)requestMoreAction {
    
    if (self.currentPage < 1) {
        self.currentPage = 1;
    }
    
    self.currentPage ++;
    __weak typeof(self) wSelf = self;
    [PictureRequestManager getPictureWithPage:self.currentPage response:^(BOOL successed, NSInteger code, NSString *responseString) {
        [wSelf.tableView.mj_footer endRefreshing];
        if (successed) {
            NSArray *resultArray = [[responseString jsonvalue] objectForKey:@"data"];
            if (resultArray && resultArray.count > 0) {
                [wSelf.jsonArray addObjectsFromArray:resultArray];
                [Tooles saveFileToLoc:kPictureUrl theFile:wSelf.jsonArray];
                for (int i = 0; i < resultArray.count; i++) {
                    NSDictionary *dict = resultArray[i];
                    TextModel *model = [[TextModel alloc] init];
                    [model yy_modelSetWithDictionary:dict];
                    [wSelf.dataArray addObject:model];
                }
            }
        }
        [wSelf.tableView reloadData];
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
        make.edges.equalTo(wSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    // 注册cell
    [_tableView registerClass:[PictureCell class] forCellReuseIdentifier:@"PictureCell"];
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextModel *model = self.dataArray[indexPath.row];
    if ([self.rowHeightCache objectForKey:model.hashId]) {
        float height = [[self.rowHeightCache objectForKey:model.hashId] floatValue];
        if (height > 0) {
            return height + 120;
        }
    }
    
    NSString *contentString = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FONT_Helvetica(15) } context:nil].size;
    
    // 缓存下来
    [self.rowHeightCache setObject:@(size.height + 20) forKey:model.hashId];
    
    return size.height + 20 + 120;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
    TextModel *textModel = self.dataArray[indexPath.row];
    
    [cell updateCellWithModel:textModel indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
