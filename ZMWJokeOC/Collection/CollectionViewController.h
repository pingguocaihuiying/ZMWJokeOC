//
//  CollectionViewController.h
//  ZMWJokeOC
//
//  Created by xiaoming on 16/9/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    PageTypeText    =   0,  // 文字
    PageTypePicture =   1   // 图片
} PageType;

@interface CollectionViewController : BaseViewController

@property (nonatomic, assign) PageType      pageType;   // 页面数据类型

@end
