//
//  PictureCell.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

@interface PictureCell : UITableViewCell


@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIImageView   *smallImageView;

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithModel:(TextModel *)model indexPath:(NSIndexPath *)indexP;

@end
