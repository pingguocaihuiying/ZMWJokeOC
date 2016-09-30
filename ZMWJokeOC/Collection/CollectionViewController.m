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

@interface CollectionViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    [self initSegment];
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
    
}

@end
