//
//  UIView+Custom.h
//  IBZApp
//
//  Created by yc on 16/6/3.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Custom)

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, assign) CGSize yc_size;
@property (nonatomic, assign) CGFloat yc_width;
@property (nonatomic, assign) CGFloat yc_height;
@property (nonatomic, assign) CGFloat yc_x;
@property (nonatomic, assign) CGFloat yc_y;
@property (nonatomic, assign) CGFloat yc_centerX;
@property (nonatomic, assign) CGFloat yc_centerY;

//得到view 所在 的  controller
-(void)setViewController:(UIViewController *)viewController;
-(UIViewController *)getViewController;
// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;

@end
