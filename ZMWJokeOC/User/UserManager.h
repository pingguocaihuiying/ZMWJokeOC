//
//  UserManager.h
//  ZMWCustomView
//
//  Created by speedx on 16/7/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject

+ (instancetype)defaultManager;

/// 用户model
@property (strong, nonatomic) UserModel     *userModel;


@end
