//
//  UIImageView+SelectPhoto.m
//  IBZApp
//
//  Created by yc on 16/5/23.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UIImageView+SelectPhoto.h"
#import "SelectPhotoTool.h"
#import <objc/runtime.h>

@implementation UIImageView (SelectPhoto)
-(void)selectPhotoWithTarget:(id)target{
    
    self.selectPhotoTool = [[SelectPhotoTool alloc] initWithTarget:target imageView:self finishHandler:nil];
    [self.selectPhotoTool setLeftSelectCountStr:@"4"];
}

-(void)selectPhotosWithTarget:(id)target{
    self.selectPhotoTool = [[SelectPhotoTool alloc] initWithTarget:target imageView:self getPhotosFromAlbum:^(NSArray<YCSelectPhotoModel *> *selectArray) {
        if ([selectArray count]>0) {
            YCSelectPhotoModel *model = [selectArray yc_objectAtIndex:0];
            self.image = model.image;
        }
    } FromCamera:^(UIImage *image) {
        
    }];
}

-(NSString *)maxSelectCoutStr{
//    YCLog(@"maxSelectCoutStr-------------+++++++++++++++++++++++++++++++++++");
    //    return objc_getAssociatedObject(self, @selector(selectPhotoTool));
    return nil;
}

-(void)setMaxSelectCoutStr:(NSString *)maxSelectCoutStr{
//    YCLog(@"setMaxSelectCoutStr+++++++++++++++++++++++++++++++++++++++++++");
    [self.selectPhotoTool setLeftSelectCountStr:maxSelectCoutStr];
//    objc_setAssociatedObject(self.selectPhotoTool, @selector(setLeftSelectCountStr:), maxSelectCoutStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)selectPhotosWithTarget:(id)target getPhotosFromAlbumBlock:(GetPhotosFromAlbumBlock)getPhotosFromAlbum FromCamera:(GetPhotosFromCameraBlock)getPhotosFromCamera{
    if (!self.selectPhotoTool) {
        self.selectPhotoTool = [[SelectPhotoTool alloc] initWithTarget:target imageView:self getPhotosFromAlbum:getPhotosFromAlbum FromCamera:getPhotosFromCamera];
    }
}

- (SelectPhotoTool *)selectPhotoTool {
//    YCLog(@"selectPhotoTool++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    return objc_getAssociatedObject(self, @selector(selectPhotoTool));
}

- (void)setSelectPhotoTool:(SelectPhotoTool *)selectPhotoTool {
//    YCLog(@"setSelectPhotoTool++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    objc_setAssociatedObject(self, @selector(selectPhotoTool), selectPhotoTool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
