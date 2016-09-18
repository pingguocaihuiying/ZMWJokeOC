//
//  TextCell.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCell : UITableViewCell

@property (nonatomic, strong) UILabel       *detailLabel;

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithString:(NSString *)string indexPath:(NSIndexPath *)indexP;

@end
