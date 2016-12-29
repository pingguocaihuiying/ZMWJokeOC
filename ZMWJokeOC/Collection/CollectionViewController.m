//
//  CollectionViewController.m
//  ZMWJokeOC
//
//  Created by xiaoming on 16/9/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "CollectionViewController.h"
#import "ZJScrollPageView.h"        // 切换滚动
#import "CollectionTextVC.h"        // 文字页面
#import "CollectionPictureVC.h"     // 图片页面

@interface CollectionViewController ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    [self initScrollPageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 滚动视图相关
- (void)initScrollPageView {
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    self.titles = @[@"文字",@"图片"];
    // 初始化 - 包含上面的条和下面的内容的view
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0 - TABBAR_HEIGHT) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:scrollPageView];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        if (index == 0) {
            childVc = [[CollectionTextVC alloc] init];
        } else {
            childVc = [[CollectionPictureVC alloc] init];
        }
    }
    
    NSLog(@"%ld-----%@",(long)index, childVc);
    
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

@end
