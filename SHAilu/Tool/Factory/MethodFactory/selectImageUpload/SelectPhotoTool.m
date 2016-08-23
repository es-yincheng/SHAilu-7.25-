//
//  UploadImage.m
//  ibaozhuang
//
//  Created by yc on 16/5/4.
//  Copyright © 2016年 成 尹. All rights reserved.
//

#import "SelectPhotoTool.h"
#import "YCNoAuthorityViewController.h"
#import "PhotoCell.h"
#import "YCPhotoTool.h"
#import "YCPhotoBrowser.h"

@implementation SelectPhotoTool 

-(instancetype)initWithTarget:(id)target imageView:(UIImageView *)imageView finishHandler:(FinishedUploadHandler)finishHandler{
    self = [super init];
    if (self) {
        self.target = target;
        self.imageView = imageView;
        self.finishHandler = finishHandler;
         NSLog(@"要重新走吗？finishHandler");
        self.maxSelectCount = 4;
        self.maxPreviewCount = 20;
        _arraySelectPhotos = [[NSMutableArray alloc] init];
        [self addActionFor:self.imageView];
    }
    return self;
}

-(instancetype)initWithTarget:(id)target imageView:(UIImageView *)imageView getPhotosFromAlbum:(GetPhotosFromAlbumBlock)getPhotosFromAlbum FromCamera:(GetPhotosFromCameraBlock)getPhotosFromCamera{
    self = [super init];
    if (self) {
        self.target              = target;
        self.imageView           = imageView;
        self.getPhotosFromAlbum  = getPhotosFromAlbum;
        self.getPhotosFromCamera = getPhotosFromCamera;
        self.maxSelectCount      = 4;
        self.maxPreviewCount     = 20;
        _arraySelectPhotos = [[NSMutableArray alloc] init];
        [self addActionFor:self.imageView];
    }
    return self;
}

-(void)addActionFor:(UIImageView*)targeet{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithSelectArray:) name:@"dealWithSelectArray" object:nil];
    
    
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImageFrom)];
    }
    [targeet removeGestureRecognizer:_tapGesture];
    targeet.userInteractionEnabled = YES;
    [targeet addGestureRecognizer:_tapGesture];
}

#pragma mark 自定义
-(void)dealWithSelectArray:(NSNotification *)not{
    NSInteger cout = [not.userInfo[@"arrayCout"] integerValue];
    NSMutableArray *selectArray = not.userInfo[@"selectArray"];
    self.maxSelectCount = cout;
    self.arraySelectPhotos = selectArray;
}


-(void)setLeftSelectCountStr:(NSString*)maxSelectCountStr{
    NSLog(@"+++++++++剩余上传图片数量+++++++++++:%@",maxSelectCountStr);
    self.maxSelectCount = [maxSelectCountStr integerValue];
    NSLog(@"self.maxSelectCount:%ld",self.maxSelectCount);
    [self addActionFor:self.imageView];
}

- (void)selectPhotosFromAblum{
    if (![self judgeIsHavePhotoAblumAuthority]) {
        //无相册访问权限
        YCNoAuthorityViewController *nvc = [[YCNoAuthorityViewController alloc] init];
        [self.target pushViewController:nvc animated:YES];
    } else {
//        self.maxSelectCount = 4-self.arraySelectPhotos.count;
        NSLog(@"到底还剩余多少个图片：%ld",self.maxSelectCount);
        YCPhotoBrowser *photoBrowser = [[YCPhotoBrowser alloc] initWithStyle:UITableViewStylePlain];
        photoBrowser.maxSelectCount = self.maxSelectCount;
        photoBrowser.arraySelectPhotos = _arraySelectPhotos.mutableCopy;
        
        [photoBrowser setDoneBlock:^(NSArray<YCSelectPhotoModel *> *selectPhotos) {
            
//            [_arraySelectPhotos addObjectsFromArray:selectPhotos];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincompatible-pointer-types"
            _arraySelectPhotos = selectPhotos;
#pragma clang diagnostic pop
            
            NSLog(@"_arraySelectPhotos：%@",_arraySelectPhotos);
            
            
            
            NSLog(@"_maxSelectCount:%ld",self.maxSelectCount);
            self.getPhotosFromAlbum(_arraySelectPhotos);
        }];
        [photoBrowser setCancelBlock:^{
            NSLog(@"CancelBlock!");
        }];
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
        [self.target presentViewController:navigationVC animated:YES completion:nil];
    }

}

#pragma mark - 判断软件是否有相册、相机访问权限
- (BOOL)judgeIsHavePhotoAblumAuthority
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

-(void)selectImageFrom{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"上传图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"从摄像头" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"camera!");
        if (![self judgeIsHavePhotoAblumAuthority]) {
            //无相册访问权限
            YCNoAuthorityViewController *nvc = [[YCNoAuthorityViewController alloc] init];
            [self.target pushViewController:nvc animated:YES];
        } else {
            [self pickImageFrom:UIImagePickerControllerSourceTypeCamera];
        }
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"album!");
        
//        [self pickImageFrom:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [self selectPhotosFromAblum];

    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel!");
    }];

    [alter addAction:camera];
    [alter addAction:album];
    [alter addAction:cancel];
    
    [self.target presentViewController:alter animated:YES completion:^{
        
    }];

}

-(void)pickImageFrom:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    pickerImage.sourceType = type;
    pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    pickerImage.delegate =self;
    pickerImage.allowsEditing =YES;//自定义照片样式
    [self.target presentViewController:pickerImage animated:YES completion:nil];
}


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


#pragma mark delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //初始化imageNew为从相机中获得的--
    
    UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.getPhotosFromCamera(imageNew);
    
    
    
    
    
    
    
    
    
//   NSLog(@"网络状态：：：：：%ld",(long)[NetWorking getNetWorkStatuCode]);
//    
//    
//#warning 根据网络决定是否压缩图片
//    NSLog(@"原图片大小：%lu m",(unsigned long)UIImageJPEGRepresentation(imageNew,1).length/1024/1024);
//    
//    //设置image的尺寸
//    
//    CGSize imagesize = imageNew.size;
//    NSLog(@"原图宽： %f，高：%f",imagesize.width,imagesize.height);
//    
////
//    imagesize.height = imageNew.size.height*0.3;
////
//    imagesize.width = imageNew.size.width*0.3;
//    
//    //对图片大小进行压缩--
//    
//    imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
//    
//    NSData *imageData = UIImageJPEGRepresentation(imageNew,0.1);
//    
//    
//    NSLog(@"图片大小：%lu k",(unsigned long)imageData.length/1024);
    
    
//    self.imageView.image = [UIImage imageWithData:imageData];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    
    
//    NSLog(@"拿到图片数据");
    
//    self.finishHandler(imageData,nil);
//    if(m_selectImage==nil)
//        
//    {
//        
//        m_selectImage = [UIImage imageWithData:imageData];
//        
//        NSLog(@"m_selectImage:%@",m_selectImage);
//        
//        [self.takePhotoButton setImage:m_selectImage forState:UIControlStateNormal];
//        
//        [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:^{
        YCLog(@"选择器消失了。");
    }];
//
//        return ;
//        
//    }

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
