//
//  NSObject+Custom.m
//  IBZApp
//
//  Created by yc on 16/6/2.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "NSObject+Custom.h"

@implementation NSObject (Custom)
//通过颜色来生成一个纯色图片
- (UIImage *)drawImageWithSize:(CGSize)size color:(UIColor *)color
{
//    // 准备绘图环境
//    UIGraphicsBeginImageContext(size);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(ctx, [color CGColor]);
//    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
//    
//    // 获取该绘图中的图片
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    
//    //结束绘图
//    UIGraphicsEndImageContext();
//    
//     // 获取当前应用路径中Documents目录下指定文件名对应的文件路径
//     NSString *path = [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingString:@"/tabBarBackgroundImage.png"];
//     NSLog(@"path:%@", path);
//     // 保存PNG图片
//     [UIImagePNGRepresentation(img) writeToFile:path atomically:YES];

    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
    
//    return img;
}

@end
