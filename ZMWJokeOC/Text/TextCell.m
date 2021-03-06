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
#import "SizeMacro.h"
#import "TextRequestManager.h"

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
- (void)updateCellWithModel:(TextModel *)model indexPath:(NSIndexPath *)indexP {
    
    NSString *contentString = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    self.detailLabel.text = contentString;
    self.detailLabel.numberOfLines = 0;
    [self.detailLabel sizeToFit];
    // 判断是否收藏，展示不同的样式
    if ([Tooles existCollectionListWithModel:model]) {
        self.backgroundColor = [UIColor colorFromHexString:@"0xDDDDDD"];
    } else {
        self.backgroundColor = kSpeedX_Color_Table_Cell_Default_Bg;
    }
}

@end
