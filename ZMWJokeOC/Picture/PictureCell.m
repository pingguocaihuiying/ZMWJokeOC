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
#import "SizeMacro.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self) wSelf = self;
        // 文字
        self.detailLabel = [Tooles getLabelWithFont:FONT_Helvetica(15) alignment:NSTextAlignmentLeft  textColor:[UIColor blackColor]];
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(10);
            make.right.equalTo(wSelf.contentView).offset(-10);
            make.top.equalTo(wSelf.contentView).offset(10);
        }];
        
        // 图片
        self.smallImageView = [Tooles getImageViewWithCornerRadius:0];
        [self.contentView addSubview:self.smallImageView];
        [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(10);
            make.right.equalTo(wSelf.contentView).offset(-10);
            make.top.equalTo(wSelf.detailLabel).offset(10);
            make.height.mas_equalTo(100);
        }];
        
        self.backgroundColor = kSpeedX_Color_Table_Cell_Default_Bg;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithModel:(TextModel *)model indexPath:(NSIndexPath *)indexP {
    
    NSString *contentString = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    self.detailLabel.text = contentString;
    self.detailLabel.numberOfLines = 0;
    [self.detailLabel sizeToFit];
    
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
}


@end
