//
//  ChatBaseViewController.m
//  Vodka
//
//  Created by jinyu on 16/7/11.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "ChatBaseViewController.h"
#import "Masonry.h"
#import "UtilMacro.h"
#import "UIView+Utils.h"
//#import "CodeFragments.h"

@interface ChatBaseViewController ()

@end

@implementation ChatBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    [[RCIM sharedRCIM] setGlobalMessageAvatarStyle:RC_USER_AVATAR_CYCLE];
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    RCMessageModel *model = self.conversationDataRepository[indexPath.item];
    
    if ([cell isKindOfClass:[RCTextMessageCell class]]) {
        if (model.messageDirection == MessageDirection_RECEIVE) {
            UILabel *label = [(RCTextMessageCell *)cell textLabel];
            label.textColor = [UIColor blackColor];
            label.font = FONT_Helvetica(14);
            label.lineBreakMode = NSLineBreakByCharWrapping;
            NSString *text = label.text;
            
            CGSize size = [text boundingRectWithSize:CGSizeMake(self.view.width - 60 - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FONT_Helvetica(14) } context:nil].size;
            RCContentView *contentView = [(RCTextMessageCell *)cell messageContentView];
            [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo([(RCTextMessageCell *)cell messageTimeLabel].mas_bottom).with.offset(10);
                make.left.equalTo(cell.contentView.mas_left).with.offset(60);
                make.size.mas_equalTo(CGSizeMake(size.width + 30, size.height + 24));
            }];
            [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(contentView).with.insets(UIEdgeInsetsMake(10, 20, 10, 10));
            }];
            UIImageView *imageView = [(RCTextMessageCell *)cell bubbleBackgroundView];
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(contentView).with.insets(UIEdgeInsetsMake(0, -10, 0, 0));
            }];
            
            [(UIView *)[(RCTextMessageCell *)cell portraitImageView]
             mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.bottom.equalTo(contentView.mas_bottom).with.offset(0);
                 make.size.mas_equalTo(((UIImageView *)[(RCTextMessageCell *)cell portraitImageView]).frame.size);
                 make.left.equalTo(cell.contentView.mas_left).with.offset(8);
             }];
            [imageView setImage:[UIImage imageNamed:@"chat_from_cell_bg_image"]];
        } else {
            UILabel *label = [(RCTextMessageCell *)cell textLabel];
            label.textColor = [UIColor whiteColor];
            label.font = FONT_Helvetica(14);
            NSString *text = label.text;
            CGSize size = [text boundingRectWithSize:CGSizeMake(self.view.width - 60 - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FONT_Helvetica(16) } context:nil].size;
            RCContentView *contentView = [(RCTextMessageCell *)cell messageContentView];
            [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if ([(RCTextMessageCell *)cell messageTimeLabel].hidden == YES || [[NSValue valueWithCGRect:[(RCTextMessageCell *)cell messageTimeLabel].frame] isEqualToValue:[NSValue valueWithCGRect:CGRectZero]]) {
                    make.centerY.mas_equalTo(cell.contentView.mas_centerY).with.offset(0);
                } else {
                    make.top.equalTo([(RCTextMessageCell *)cell messageTimeLabel].mas_bottom).with.offset(10);
                }
                
                make.right.equalTo(cell.contentView.mas_right).with.offset(-60);
                make.size.mas_equalTo(CGSizeMake(size.width + 30, size.height + 24));
            }];
            [label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(contentView).with.insets(UIEdgeInsetsMake(10, 10, 10, 20));
            }];
            UIImageView *imageView = [(RCTextMessageCell *)cell bubbleBackgroundView];
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, -10));
            }];
            
            [(UIView *)[(RCTextMessageCell *)cell portraitImageView]
             mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.bottom.equalTo(contentView.mas_bottom).with.offset(0);
                 make.size.mas_equalTo(((UIImageView *)[(RCTextMessageCell *)cell portraitImageView]).frame.size);
                 make.right.equalTo(cell.contentView.mas_right).with.offset(-8);
             }];
            [imageView setImage:[UIImage imageNamed:@"chat_to_cell_bg_image"]];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    RCMessageModel *model = self.conversationDataRepository[indexPath.item];
    
    if ([model.content isKindOfClass:[RCTextMessage class]]) {
        if (model.messageDirection == MessageDirection_RECEIVE) {
            CGSize size = [[(RCTextMessage *)model.content content] boundingRectWithSize:CGSizeMake(self.view.width - 60 - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: FONT_Helvetica(14) } context:nil].size;
            return CGSizeMake(self.view.width, 40 + size.height + 40);
        }
    }
    
    return size;
}

@end
