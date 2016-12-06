//
//  CollectionViewController.m
//  ZMWJokeOC
//
//  Created by xiaoming on 16/9/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "CollectionViewController.h"
#import <HMSegmentedControl.h>
#import <Masonry.h>
#import "TextModel.h"
#import <YYModel.h>
#import <MJRefresh.h>
#import "TextCell.h"
#import "Tooles.h"
#import "TextRequestManager.h"

@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) NSMutableArray    *jsonArray;     // 保存本地用的
@property (nonatomic, strong) NSCache           *rowHeightCache;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    [self initSegment];
    
    self.dataArray = [NSMutableArray array];
    self.jsonArray = [NSMutableArray array];
    self.rowHeightCache = [[NSCache alloc] init];
    // 初始化表格
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取本地收藏的数据
    [self getCollectionList:self.pageType];
}

#pragma mark - 初始化segment
- (void)initSegment {
    __weak typeof(self) wSelf = self;
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"文字", @"图片"]];
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.right.equalTo(wSelf.view).offset(0);
        make.top.equalTo(wSelf.view).offset(NAVIGATIONBAR_HEIGHT);
        make.height.mas_equalTo(44);
    }];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectionIndicatorColor = [UIColor blueColor];
    self.segmentedControl.backgroundColor = self.view.backgroundColor;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentControl {
    if (segmentControl.selectedSegmentIndex == 0) {
        self.pageType = PageTypeText;
    } else {
        self.pageType = PageTypePicture;
    }
    [self getCollectionList:self.pageType];
}

#pragma mark - 初始化表格
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
        make.edges.equalTo(wSelf.view).with.insets(UIEdgeInsetsMake(44 + NAVIGATIONBAR_HEIGHT, 0, TABBAR_HEIGHT, 0));
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextModel *model = self.dataArray[indexPath.row];
    if ([self.rowHeightCache objectForKey:model.hashId]) {
        float height = [[self.rowHeightCache objectForKey:model.hashId] floatValue];
        if (height > 0) {
            return height;
        }
    }
    NSString *contentString = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FONT_Helvetica(15) } context:nil].size;
    
    // 缓存下来
    [self.rowHeightCache setObject:@(size.height + 20) forKey:model.hashId];
    
    return size.height + 20;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
    TextModel *textModel = self.dataArray[indexPath.row];
    [cell updateCellWithModel:textModel indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TextModel *textModel = self.dataArray[indexPath.row];
    [Tooles saveOrRemoveToCollectionListWithModel:textModel];
    // 获取本地收藏的数据
    [self getCollectionList:self.pageType];
}

#pragma mark - 获取本地收藏的数据列表
- (void)getCollectionList:(PageType)pageType {
    [self.dataArray removeAllObjects];
    self.dataArray = [NSMutableArray array];
    [Tooles getFileFromLoc:kContentUrl_Collection into:self.dataArray isModel:YES];
    [self.tableView reloadData];
}

@end
