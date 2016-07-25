//
//  UIImageView+SelectPhoto.h
//  IBZApp
//
//  Created by yc on 16/5/23.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPhotoTool.h"

@interface UIImageView (SelectPhoto)
//@property (nonatomic ,strong) id target;
@property (nonatomic ,strong) SelectPhotoTool *selectPhotoTool;
@property (nonatomic ,strong) NSString *maxSelectCoutStr;


-(void)selectPhotoWithTarget:(id)target;
-(void)selectPhotosWithTarget:(id)target;
-(void)selectPhotosWithTarget:(id)target getPhotosFromAlbumBlock:(GetPhotosFromAlbumBlock)getPhotosFromAlbum FromCamera:(GetPhotosFromCameraBlock)getPhotosFromCamera;

@end
