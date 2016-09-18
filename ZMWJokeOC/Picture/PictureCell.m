//
//  PictureCell.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "PictureCell.h"
#import "Tooles.h"
#import "UtilMacro.h"
#import "UIColor+IOSUtils.h"
#import <Masonry.h>
#import "UtilMacro.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [Tooles getLabelWithFont:FONT_Helvetica(16) alignment:NSTextAlignmentLeft textColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.nameLabel];
        
        self.detailLabel = [Tooles getLabelWithFont:FONT_Helvetica(14) alignment:NSTextAlignmentRight  textColor:[UIColor colorFromHexString:@"0xCCCCCC"]];
        [self.contentView addSubview:self.detailLabel];
        
        self.headerImageView = [Tooles getImageViewWithCornerRadius:25];
        self.headerImageView.image = [UIImage imageNamed:@"Default_Avatar"];
        [self.contentView addSubview:self.headerImageView];
        
        __weak typeof(self) wSelf = self;
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(10);
            make.centerY.equalTo(wSelf.contentView);
        }];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.contentView).offset(0);
            make.centerY.equalTo(wSelf.contentView);
        }];
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.contentView).offset(-15);
            make.centerY.equalTo(wSelf.contentView);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.backgroundColor = kSpeedX_Color_Table_Cell_Default_Bg;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithString:(NSString *)string indexPath:(NSIndexPath *)indexP headerImage:(UIImage *)image {
    
    
}


@end
