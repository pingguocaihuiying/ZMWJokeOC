//
//  LocalAbumViewController.m
//  ZMWJokeOC
//
//  Created by speedx on 16/9/28.
//  Copyright © 2016年 speedx. All rights reserved.
//

#import "LocalAbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface LocalAbumViewController ()

@property (nonatomic, strong) NSMutableArray        *localImageUrlArray;

@end

@implementation LocalAbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"本地";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadImagesFromLibrary];
}

//获取相册的所有图片
- (void)reloadImagesFromLibrary
{
    __weak typeof(self) wSelf = self;
    self.localImageUrlArray = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        // 读取失败回调。
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
            }else{
                NSLog(@"相册访问失败.");
            }
        };
        
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
            if (result!=NULL) {
                
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    
                    NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                    NSLog(@"url === %@",urlstr);
                    [wSelf.localImageUrlArray addObject:urlstr];
                    //NSLog(@"urlStr is %@",urlstr);
                    /*result.defaultRepresentation.fullScreenImage//图片的大图
                     result.thumbnail                             //图片的缩略图小图
                     //                    NSRange range1=[urlstr rangeOfString:@"id="];
                     //                    NSString *resultName=[urlstr substringFromIndex:range1.location+3];
                     //                    resultName=[resultName stringByReplacingOccurrencesOfString:@"&ext=" withString:@"."];//格式demo:123456.png
                     */
                }
            }
        };
        
        ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
            if (group!=nil) {
                [group enumerateAssetsUsingBlock:groupEnumerAtion];
            }
        };
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll
                               usingBlock:libraryGroupsEnumeration
                             failureBlock:failureblock];
        
    });
}

@end
