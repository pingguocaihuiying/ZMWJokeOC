//
//  PictureCell.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"
#import "LCStarView.h"      // 点赞view

@interface PictureCell : UITableViewCell

@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIImageView   *smallImageView;
@property (nonatomic, strong) LCStarView    *starView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^ collectionClickBlock) (NSIndexPath *indexPath);

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithModel:(TextModel *)model indexPath:(NSIndexPath *)indexP;

@end
