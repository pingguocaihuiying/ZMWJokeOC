//
//  BaseViewController.m
//  Vodka
//
//  Created by Mark C.J. on 15-1-13.
//  Copyright (c) 2015年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController () {
    
}

@end

@implementation BaseViewController


-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self baseNextPageTitleButton:@"返回"];
    
    // 设置导航栏的 title 颜色 大小 如果修改的多的话，封装成类方法。
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor blackColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - 下个页面的返回按钮------（传空格就是只有一个箭头）。
-(void)baseNextPageTitleButton:(NSString *)nextPageTitleString {
    NSString *titleString = nil;
    if (nextPageTitleString == nil || [nextPageTitleString isEqualToString:@""]) {//传空 ，默认返回。
        titleString = NSLocalizedString(@"kAll_back", nil);
    }else{
        titleString = nextPageTitleString;
    }
    //下一级界面返回按钮
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = titleString;
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
}

/**
 *  导航栏左边按钮  重写返回按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏左边按钮
 */
- (void)leftButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 12, 21)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    if (![imageString isEmptyString]) {
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 0;// 值越大越靠左边
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithName:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 44)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (![imageString isEmptyString]) {
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    if (![name isEmptyString]) {
        [button.titleLabel sizeToFit];
        [button setFrame:CGRectMake(0, 0, button.titleLabel.width, 44)];
    }else{
        [button setFrame:CGRectMake(0, 0, 60, 44)];// 太大的话，影响title
    }
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮---靠右边的(点击事件小，在titleView太长的时候正好有个按钮和rightBtn太近的时候用的)
 *
 *  @param name        按钮名称
 *  @param imageString 按钮图片
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithNameRight:(NSString *)name image:(NSString *)imageString block:(void(^)(UIButton *btn))block{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 80, 44)];
    // 右边按钮  右对齐
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (![imageString isEmptyString]) {
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateHighlighted];
    }
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    if (![name isEmptyString]) {
        [button.titleLabel sizeToFit];
        [button setFrame:CGRectMake(0, 0, button.titleLabel.width, 44)];
    }else{
        [button setFrame:CGRectMake(0, 0, 40, 44)];// 太大的话，影响title
    }
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *btn) {
        block(button);
    }];
}

/**
 *  导航栏右边按钮 自己传入自定义的view 给右按钮
 *
 *  @param view        自定义按钮
 *  @param block       返回导航栏右边按钮
 */
- (void)rightButtonWithView:(UIView *)view block:(void(^)(UIView *view))block{
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;// 值越大越靠左边
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    
    /// block 回调方法。
    if (block == nil) {
        return;
    }
    __weak typeof(view) weakView = view;
    [view setTapActionWithBlock:^{
        block(weakView);
    }];
}

/// 获取当前控制器，把UIViewController替换为需要的控制器就OK了
- (UIViewController *)viewController {
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
