//
//  UserModel.m
//  ZMWCustomView
//
//  Created by speedx on 16/7/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    }
}

@end
