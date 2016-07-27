//
//  UIView+Custom.m
//  IBZApp
//
//  Created by yc on 16/6/3.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UIView+Custom.h"
#import <UIKit/UIKit.h>

@implementation UIView (Custom)

@dynamic viewController;

#pragma mark 大小、位置属性
- (void)setYc_size:(CGSize)yc_size{
    CGRect frame = self.frame;
    frame.size = yc_size;
    self.frame = frame;
}

- (CGSize)yc_size{
    return self.frame.size;
}

- (void)setYc_width:(CGFloat)yc_width{
    CGRect frame = self.frame;
    frame.size.width = yc_width;
    self.frame = frame;
}

- (CGFloat)yc_width{
    return self.frame.size.width;
}

- (void)setYc_height:(CGFloat)yc_height{
    CGRect frame = self.frame;
    frame.size.height = yc_height;
    self.frame = frame;
}

- (CGFloat)yc_height{
    return self.frame.size.height;
}

- (void)setYc_x:(CGFloat)yc_x{
    CGRect frame = self.frame;
    frame.origin.x = yc_x;
    self.frame = frame;
}

- (CGFloat)yc_x{
    return self.frame.origin.x;
}

- (void)setYc_y:(CGFloat)yc_y{
    CGRect frame = self.frame;
    frame.origin.y = yc_y;
    self.frame = frame;
}

- (CGFloat)yc_y{
    return self.frame.origin.y;
}

- (void)setYc_centerX:(CGFloat)yc_centerX{
    CGPoint center = self.center;
    center.x = yc_centerX;
    self.center = center;
}

- (CGFloat)yc_centerX{
    return self.center.x;
}

- (void)setYc_centerY:(CGFloat)yc_centerY{
    CGPoint center = self.center;
    center.y = yc_centerY;
    self.center = center;
}

- (CGFloat)yc_centerY{
    return self.center.y;
}

#pragma mark - other

-(void)setViewController:(UIViewController *)viewController{
    
}

-(UIViewController *)getViewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}

@end
