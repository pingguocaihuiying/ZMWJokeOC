//
//  CollectionPictureVC.m
//  ZMWJokeOC
//
//  Created by zhangmingwei on 2016/12/29.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "CollectionPictureVC.h"
#import <Masonry.h>
#import "PictureCell.h"
#import "PictureRequestManager.h"
#import "TextModel.h"
#import <YYModel.h>
#import "Tooles.h"

#import "MSSBrowseDefine.h"

@interface CollectionPictureVC ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) NSMutableArray    *jsonArray;     // 保存本地用的

@property (nonatomic, assign) int               currentPage;
@property (nonatomic, strong) NSCache           *rowHeightCache;

@property (nonatomic, strong) NSMutableArray    *arrayImageUrl;
@property (nonatomic, assign) int               currentSelectPicture;   // 点击当前cell或者滚动大图到的位置

@end

@implementation CollectionPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图文";
    self.dataArray = [NSMutableArray array];
    self.jsonArray = [NSMutableArray array];
    self.rowHeightCache = [[NSCache alloc] init];
    
    [self initPhotoBrowerAction];
    
    // 初始化表格
    [self initTableView];
    __weak typeof(self) wSelf = self;
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kCurrentPhotoIndex" object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.currentSelectPicture = [[x object] intValue];
            NSIndexPath *indexP = [NSIndexPath indexPathForRow:wSelf.currentSelectPicture inSection:0];
            [wSelf.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取本地收藏的数据
    [self getCollectionList];
}

#pragma mark - 初始化大图相关
- (void)initPhotoBrowerAction {
    self.arrayImageUrl = [NSMutableArray array];
}

#pragma mark - 获取本地缓存的数据
- (BOOL)getLocalArray {
    NSMutableArray *arr = [NSMutableArray array];
    if ([Tooles getFileFromLoc:kPictureUrl into:arr]) {
        self.dataArray = [NSMutableArray array];
        self.arrayImageUrl = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i < arr.count; i++) {
            NSDictionary *dict = arr[i];
            TextModel *model = [[TextModel alloc] init];
            [model yy_modelSetWithDictionary:dict];
            [self.dataArray addObject:model];
            [self.arrayImageUrl addObject:model.url];
        }
        [self.tableView reloadData];
        return YES;
    }
    return NO;
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
            return height;
        }
    }
    NSString *contentString = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FONT_Helvetica(15) } context:nil].size;
    // 缓存下来
    [self.rowHeightCache setObject:@(size.height + 20 + 210 + 35) forKey:model.hashId];
    return size.height + 20 + 210 + 35;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    __weak typeof(self) wSelf = self;
    __weak typeof(cell) wCell = cell;
    [cell setCollectionClickBlock:^(NSIndexPath *indexP) {
        TextModel *textModel = wSelf.dataArray[indexPath.row];
        if ([Tooles existCollectionListWithModel:textModel]) {
            [wCell.starView goCollection:NO];
        } else {
            [wCell.starView goCollection:YES];
        }
        [Tooles saveOrRemoveToCollectionListWithModel:textModel];
        //        [wSelf.tableView reloadData];// 因为点击的时候，收藏按钮已经变化了，所有不用再刷新tableView了
    }];
    TextModel *textModel = self.dataArray[indexPath.row];
    [cell updateCellWithModel:textModel indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentSelectPicture = (int)indexPath.row;
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
    // 加载网络图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < [self.arrayImageUrl count];i++)
    {
        UIImageView     *imageView = cell.smallImageView;
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = self.arrayImageUrl[i];// 加载网络图片大图地址
        browseItem.smallImageView = imageView;// 小图
        [browseItemArray addObject:browseItem];
    }
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    [bvc showBrowseViewController];
}

#pragma mark - 获取本地收藏的数据列表
- (void)getCollectionList {
    [self.dataArray removeAllObjects];
    self.dataArray = [NSMutableArray array];
    [Tooles getFileFromLoc:kPictureUrl_Collection into:self.dataArray isModel:YES];
    [self.arrayImageUrl removeAllObjects];
    self.arrayImageUrl = [NSMutableArray array];
    for (TextModel *model in self.dataArray) {
        if (model.url && ![model.url isEmptyString]) {
            [self.arrayImageUrl addObject:model.url];
        }
    }
    [self.tableView reloadData];
}

@end
