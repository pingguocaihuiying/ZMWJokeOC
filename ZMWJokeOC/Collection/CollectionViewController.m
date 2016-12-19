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
#import "TextCell.h"
#import "Tooles.h"
#import "TextRequestManager.h"
// 图片相关
#import "PictureCell.h"
#import "PictureRequestManager.h"
#import <YYModel.h>
#import "MSSBrowseDefine.h"


@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, strong) NSMutableArray    *jsonArray;     // 保存本地用的
@property (nonatomic, strong) NSCache           *rowHeightCache;
// 图片相关
@property (nonatomic,strong)  NSMutableArray    *arrayImageUrl;
@property (nonatomic, assign) int               currentSelectPicture;   // 点击当前cell或者滚动大图到的位置

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    [self initSegment];
    self.pageType = PageTypeText;
    self.dataArray = [NSMutableArray array];
    self.jsonArray = [NSMutableArray array];
    self.rowHeightCache = [[NSCache alloc] init];
    self.arrayImageUrl = [NSMutableArray array];
    
    // 初始化表格
    [self initTableView];
    __weak typeof(self) wSelf = self;
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kCurrentPhotoIndex" object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.currentSelectPicture = [[x object] intValue];
            NSIndexPath *indexP ;
            if (wSelf.dataArray.count == 0) {
                return ;
            } else if (wSelf.dataArray.count <= wSelf.currentSelectPicture) {
                indexP = [NSIndexPath indexPathForRow:0 inSection:0];
                return ; // 避免崩溃
            } else {
                indexP = [NSIndexPath indexPathForRow:wSelf.currentSelectPicture inSection:0];
            }
            [wSelf.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        });
        
    }];
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
    if (self.pageType == PageTypeText) {
        [self.rowHeightCache setObject:@(size.height + 20) forKey:model.hashId];
        return size.height + 20;
    } else {
        [self.rowHeightCache setObject:@(size.height + 20 + 210) forKey:model.hashId];
        return size.height + 20 + 210;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pageType == PageTypeText) {
        return 100.0;
    } else {
        return 250.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextModel *textModel = self.dataArray[indexPath.row];
    if (self.pageType == PageTypeText) {
        TextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
        [textCell updateCellWithModel:textModel indexPath:indexPath];
        return textCell;
    } else {
        PictureCell *picCell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
        [picCell updateCellWithModel:textModel indexPath:indexPath];
        return picCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.pageType == PageTypeText) { // 文字
        TextModel *textModel = self.dataArray[indexPath.row];
        [Tooles saveOrRemoveToCollectionListWithModel:textModel];
        // 获取本地收藏的数据
        [self getCollectionList:self.pageType];
    } else { // 图片
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
}

#pragma mark - 获取本地收藏的数据列表
- (void)getCollectionList:(PageType)pageType {
    [self.dataArray removeAllObjects];
    self.dataArray = [NSMutableArray array];
    if (self.pageType == PageTypeText) {
        [Tooles getFileFromLoc:kContentUrl_Collection into:self.dataArray isModel:YES];
    } else {
        [Tooles getFileFromLoc:kPictureUrl_Collection into:self.dataArray isModel:YES];
        [self.arrayImageUrl removeAllObjects];
        self.arrayImageUrl = [NSMutableArray array];
        for (TextModel *model in self.dataArray) {
            if (model.url && ![model.url isEmptyString]) {
                [self.arrayImageUrl addObject:model.url];
            }
        }
    }
    [self.tableView reloadData];
}

@end
