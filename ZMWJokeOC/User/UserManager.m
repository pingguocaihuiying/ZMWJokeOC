//
//  UserManager.m
//  ZMWCustomView
//
//  Created by speedx on 16/7/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)defaultManager
{
    static UserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[self alloc]init];
    });
    
    return userManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 只能执行
        self.userModel = [[UserModel alloc] init];
    }
    return self;
}

@end
