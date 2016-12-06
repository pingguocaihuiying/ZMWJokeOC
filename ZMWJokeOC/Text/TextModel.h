//
//  TextModel.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <Foundation/Foundation.h>
// 想要保存到本地，需要NSCoding
@interface TextModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString      *content;
@property (nonatomic, strong) NSString      *hashId;
@property (nonatomic, strong) NSString      *updatetime;
@property (nonatomic, assign) int           unixtime;

@property (nonatomic, strong) NSString      *url;   // 图片特有的

@end
