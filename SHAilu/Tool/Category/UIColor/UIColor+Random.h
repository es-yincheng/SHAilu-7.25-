//
//  UIColor+Random.h
//  IBZApp
//
//  Created by yc on 16/5/23.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Random)

+(UIColor *)randomColor;
// 16进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

@end
