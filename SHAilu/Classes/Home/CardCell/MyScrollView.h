//
//  MyScrollView.h
//  Test
//
//  Created by skma on 16/3/5.
//  Copyright © 2016年 skma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollview : UIView

//@property (nonatomic, readonly) CGSize contentSize;
//@property (nonatomic, readonly) CGPoint contentOffSet;

/**
 * 自定义初始化方法
 **/
- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target;

/**
 * 加载网络图片
 **/
//- (void)loadImagesWithUrl:(NSArray *)array;
//- (void)loadImagesWithUrl:(NSArray *)images colors:(NSArray *)colors;
- (void)loadWithData:(NSDictionary *)data;

/**
 * 滑动时抽屉效果
 **/
- (void)scroll;


@end
