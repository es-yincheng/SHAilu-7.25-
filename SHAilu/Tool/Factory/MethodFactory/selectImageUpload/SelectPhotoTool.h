//
//  UploadImage.h
//  ibaozhuang
//
//  Created by yc on 16/5/4.
//  Copyright © 2016年 成 尹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSelectPhotoModel.h"

@interface SelectPhotoTool : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

typedef void(^FinishedUploadHandler)(NSData* imageData, NSError* error);
typedef void (^GetPhotosFromAlbumBlock)(NSArray<YCSelectPhotoModel *> *selectArray);
typedef void (^GetPhotosFromCameraBlock)(UIImage *image);

@property(nonatomic, strong) id target;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, weak) FinishedUploadHandler finishHandler;
@property(nonatomic, strong) UITapGestureRecognizer *tapGesture;

/** 最大选择数 default is 4 */
@property (nonatomic, assign) NSInteger maxSelectCount;

/** 预览图最大显示数 default is 20 */
@property (nonatomic, assign) NSInteger maxPreviewCount;

@property (nonatomic ,strong) NSMutableArray<YCSelectPhotoModel *> *arraySelectPhotos;
//从相册拿到图片后回调
@property (nonatomic, copy) GetPhotosFromAlbumBlock getPhotosFromAlbum;
//从相机拿到图片后回调
@property (nonatomic, copy) GetPhotosFromCameraBlock getPhotosFromCamera;


-(instancetype)initWithTarget:(id)target
                    imageView:(UIImageView*)imageView
                finishHandler:(FinishedUploadHandler)finishHandler
                ;

-(instancetype)initWithTarget:(id)target imageView:(UIImageView *)imageView getPhotosFromAlbum:(GetPhotosFromAlbumBlock)getPhotosFromAlbum FromCamera:(GetPhotosFromCameraBlock)getPhotosFromCamera;

//-(void)addActionFor:(UIImageView*)targeet;
-(void)setLeftSelectCountStr:(NSString*)maxSelectCountStr;
@end
