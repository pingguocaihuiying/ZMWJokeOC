//
//  ChatViewController.h
//  ZMWJokeOC
//
//  Created by zhangmingwei on 2016/12/15.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "BaseViewController.h"

#import "LLConversationModel.h"
#import "LLChatInputDelegate.h"
#import "LLVoiceIndicatorView.h"

@interface ChatViewController : BaseViewController<LLChatInputDelegate>

@property (nonatomic, strong)  LLConversationModel *conversationModel;

- (void)fetchMessageList;

- (void)refreshChatControllerForReuse;

@end
