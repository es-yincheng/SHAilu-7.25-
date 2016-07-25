//
//  YCPhotoBrowser.h
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCSelectPhotoModel;

@interface YCPhotoBrowser : UITableViewController
//最大选择数
@property (nonatomic, assign) NSInteger maxSelectCount;

//当前已经选择的图片
@property (nonatomic, strong) NSMutableArray<YCSelectPhotoModel *> *arraySelectPhotos;

//选则完成后回调
@property (nonatomic, copy) void (^DoneBlock)(NSArray<YCSelectPhotoModel *> *);

//取消选择后回调
@property (nonatomic, copy) void (^CancelBlock)();


@end
