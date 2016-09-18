//
//  TextCell.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "TextCell.h"
#import "Tooles.h"
#import "UtilMacro.h"
#import "UIColor+IOSUtils.h"
#import <Masonry.h>
#import "UtilMacro.h"

@implementation TextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self) wSelf = self;
        self.detailLabel = [Tooles getLabelWithFont:FONT_Helvetica(15) alignment:NSTextAlignmentLeft  textColor:[UIColor blackColor]];
        [self.contentView addSubview:self.detailLabel];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(10);
            make.right.equalTo(wSelf.contentView).offset(-10);
            make.top.equalTo(wSelf.contentView).offset(10);
        }];
        
        self.backgroundColor = kSpeedX_Color_Table_Cell_Default_Bg;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

#pragma mark - 自定义的cell赋值方法.
- (void)updateCellWithString:(NSString *)string indexPath:(NSIndexPath *)indexP {
    
    self.detailLabel.text = string;
}

@end
