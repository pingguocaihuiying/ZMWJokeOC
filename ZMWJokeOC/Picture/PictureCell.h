//
//  PictureCell.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCell : UITableViewCell

@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UIImageView   *headerImageView;      // 头像特有的

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithString:(NSString *)string indexPath:(NSIndexPath *)indexP headerImage:(UIImage *)image;

@end
