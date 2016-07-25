//
//  YCShowBigImgViewController.h
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class YCSelectPhotoModel;
@interface YCShowBigImgViewController : UIViewController

@property (nonatomic, strong) NSArray<PHAsset *> *assets;

@property (nonatomic, strong) NSMutableArray<YCSelectPhotoModel *> *arraySelectPhotos;

@property (nonatomic, assign) NSInteger selectIndex; //选中的图片下标

@property (nonatomic, assign) NSInteger maxSelectCount; //最大选择照片数

@property (nonatomic, assign) BOOL showPopAnimate; //pop时是否使用过渡动画

@property (nonatomic, assign) BOOL shouldReverseAssets; //是否需要对接收到的图片数组进行逆序排列

@property (nonatomic, copy) void (^onSelectedPhotos)(NSArray<YCSelectPhotoModel *> *);

@end
