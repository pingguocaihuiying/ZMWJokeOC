//
//  SpeedxAssistantViewController.m
//  Vodka
//
//  Created by jinyu on 16/6/27.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "SpeedxAssistantViewController.h"
#import <objc/runtime.h>
#import "UIColor+IOSUtils.h"
#import "UIView+Utils.h"
#import "SizeMacro.h"
#import "Masonry.h"

@interface SpeedxAssistantViewController ()

@end

@implementation SpeedxAssistantViewController

- (id)initWithConversationType:(RCConversationType)conversationType targetId:(NSString *)targetId {
    if (self = [super initWithConversationType:conversationType targetId:targetId]) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RCIM sharedRCIM] setGlobalMessageAvatarStyle:RC_USER_AVATAR_CYCLE];
    self.displayUserNameInCell = NO;
    
    self.chatSessionInputBarControl.alpha = 1.0;
    self.chatSessionInputBarControl.frame = CGRectMake(0, self.view.height - 50, SCREEN_WIDTH, 50);
    
    self.conversationMessageCollectionView.top = 64;
    self.conversationMessageCollectionView.height = self.view.height - 64;
    [self.view setBackgroundColor:[UIColor colorFromHexString:@"0xF7F7F7"]];
    [self.conversationMessageCollectionView setBackgroundColor:[UIColor colorFromHexString:@"0xF7F7F7"]];
}

@end
