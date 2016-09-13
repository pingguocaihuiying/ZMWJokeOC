//
//  UserModel.h
//  ZMWCustomView
//
//  Created by speedx on 16/7/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/// 用户id
@property (strong, nonatomic) NSString      *userId;
/// 用户名称
@property (strong, nonatomic) NSString      *userName;
/// 用户sessionId
@property (strong, nonatomic) NSString      *sessionId;

@end
