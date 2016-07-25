//
//  YCThumbnailViewController.h
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "YCSelectPhotoModel.h"
#import "YCPhotoBrowser.h"

@interface YCThumbnailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//相册属性
@property (nonatomic, strong) PHAssetCollection *assetCollection;

//当前已经选择的图片
@property (nonatomic, strong) NSMutableArray<YCSelectPhotoModel *> *arraySelectPhotos;

//最大选择数
@property (nonatomic, assign) NSInteger maxSelectCount;

@property (weak, nonatomic) IBOutlet UILabel *labCount;

@property (weak, nonatomic) IBOutlet UIView *btnDone;

//用于回调上级列表，把已选择的图片传回去
@property (nonatomic, weak) YCPhotoBrowser *sender;

//选则完成后回调
@property (nonatomic, copy) void (^DoneBlock)(NSArray<YCSelectPhotoModel *> *);
//取消选择后回调
@property (nonatomic, copy) void (^CancelBlock)();

@end
