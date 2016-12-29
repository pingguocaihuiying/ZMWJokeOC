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
            make.top.equalTo(wSelf.detailLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(200);
            make.centerX.equalTo(wSelf.contentView);
        }];
        
        // 点赞的view
        UIImage *maskImage = [UIImage imageNamed:@"collect_fill"];
        UIImage *lineImage = [UIImage imageNamed:@"collect_line"];
        self.starView = [[LCStarView alloc] init];
        self.starView.frame = CGRectMake(0, 0, 30, 30); // 必须有frame才可以
        self.starView.maskImage = maskImage;
        self.starView.borderImage = lineImage;
        self.starView.fillColor = [UIColor colorWithRed:0.94 green:0.27 blue:0.32 alpha:1];
        [self.contentView addSubview:self.starView];
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.contentView).offset(-20);
            make.top.equalTo(wSelf.smallImageView.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [self.starView setTapActionWithBlock:^{
            if (wSelf.collectionClickBlock) {
                wSelf.collectionClickBlock(wSelf.indexPath);
            }
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
    // 判断是否收藏，展示不同的样式
    if ([Tooles existCollectionListWithModel:model]) {
        self.starView.fillView.transform = CGAffineTransformMakeScale(1, 1);
    } else {
        self.starView.fillView.transform = CGAffineTransformMakeScale(FLT_MIN, FLT_MIN);
    }
}


@end
