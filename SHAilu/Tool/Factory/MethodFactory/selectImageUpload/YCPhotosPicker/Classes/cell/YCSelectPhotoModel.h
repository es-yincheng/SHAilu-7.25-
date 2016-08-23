//
//  YCSelectPhotoModel.h
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface YCSelectPhotoModel : NSObject
@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, copy  ) NSString *imageName;
@property (nonatomic, strong) PHAsset  *asset;
@end
