//
//  YCPotosPickerViewController.h
//  YCPhotosPiker
//
//  Created by yc on 16/5/25.
//  Copyright © 2016年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "YCSelectPhotoModel.h"
typedef void (^SetMaxSelectCout)(NSInteger maxSelectCout);
typedef void (^GetPhotosBlock)(NSArray<YCSelectPhotoModel *> *selectArray ,NSInteger maxSelectCout);

@interface YCPotosPickerViewController : UIViewController
@property (nonatomic ,strong) NSMutableArray<PHAsset *> *arrayDataSources;
@property (nonatomic ,strong) NSMutableArray<YCSelectPhotoModel *> *arraySelectPhotos;
@property (nonatomic ,strong)  UICollectionView *collectionView;

/** 最大选择数 default is 10 */
@property (nonatomic, assign) NSInteger maxSelectCount;

/** 预览图最大显示数 default is 20 */
@property (nonatomic, assign) NSInteger maxPreviewCount;

//拿到图片后回调
@property (nonatomic, copy) GetPhotosBlock getPhotos;

-(instancetype)initWithGetPhotosBlock:(GetPhotosBlock)getPhotos;
@end
