//
//  MSSBrowseCollectionViewCell.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "MSSBrowseCollectionViewCell.h"
#import "MSSBrowseDefine.h"

@interface MSSBrowseCollectionViewCell ()

@property (nonatomic,copy)MSSBrowseCollectionViewCellTapBlock tapBlock;
@property (nonatomic,copy)MSSBrowseCollectionViewCellDoubleTapBlock doubleTapBlock;
@property (nonatomic,copy)MSSBrowseCollectionViewCellLongPressBlock longPressBlock;

@end

@implementation MSSBrowseCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self createCell];
    }
    return self;
}

- (void)createCell
{
    _zoomScrollView = [[MSSBrowseZoomScrollView alloc]init];
    __weak __typeof(self)weakSelf = self;
    [_zoomScrollView tapClick:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.tapBlock(strongSelf);
    }];
    [self.contentView addSubview:_zoomScrollView];
    
    _loadingView = [[MSSBrowseLoadingImageView alloc]init];
    [_zoomScrollView addSubview:_loadingView];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [self.contentView addGestureRecognizer:longPressGesture];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 2;
    [self.contentView addGestureRecognizer:tap];
    
}

- (void)tapClick:(MSSBrowseCollectionViewCellTapBlock)tapBlock
{
    _tapBlock = tapBlock;
}

- (void)doubleTapClick:(MSSBrowseCollectionViewCellDoubleTapBlock)doubleTapBlock {
    _doubleTapBlock = doubleTapBlock;
}


- (void)longPress:(MSSBrowseCollectionViewCellLongPressBlock)longPressBlock
{
    _longPressBlock = longPressBlock;
}

- (void)doubleTapGesture:(UITapGestureRecognizer *)gesture
{
    if(_doubleTapBlock)
    {
        if(gesture.numberOfTouches == 2)
        {
            _doubleTapBlock(self);
        } else {
            _tapBlock(self);
        }
    }
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if(_longPressBlock)
    {
        if(gesture.state == UIGestureRecognizerStateBegan)
        {
            _longPressBlock(self);
        }
    }
}

@end
