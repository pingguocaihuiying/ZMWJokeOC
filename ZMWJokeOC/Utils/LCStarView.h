//
//  LCStarView.h
//  StarView
//
//  Created by bawn on 9/15/15.
//  Copyright (c) 2015 bawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCStarView : UIView

@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, strong) UIImage *borderImage;
@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, strong) UIView *fillView;

/**
 *  @param isCollectioning YES:收藏，NO:取消收藏
 */
- (void)goCollection:(BOOL)isCollectioning;

@end
