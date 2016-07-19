//
//  YCTabBarController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCTabBarController.h"
#import "ZLCustomeSegmentControlView.h"
//#import "YCTabBar.h"

#define SelectItemColor [UIColor colorWithRed:0.624 green:0.494 blue:0.200 alpha:1.000]

@interface YCTabBarController ()

@end

@implementation YCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithHex:0x212F3F];
//    self.view.backgroundColor = [UIColor redColor];
    
//    self.tabBar.backgroundColor = [UIColor colorWithRed:0.071 green:0.035 blue:0.004 alpha:1.000];
//    self.tabBar.selectionIndicatorImage = [self buttonImageFromColor:SelectItemColor];
//    
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UILabel *xline = [[UILabel alloc] initWithFrame:CGRectMake(0, -1, ScreenWith, 1)];
    xline.backgroundColor = YCNavTitleColor;
    [self.tabBar addSubview:xline];
    
    ZLCustomeSegmentControlView *v = [[ZLCustomeSegmentControlView alloc] init];
    
    v.titles = @[@"定制", @"订单", @"我的"];
    v.duration = 0.7f;
    
    [v setButtonOnClickBlock:^(NSInteger tag, NSString *title) {
        NSLog(@"index = %ld, title = %@", (long)tag, title);
        
        
        self.selectedIndex = tag;
    }];
    
    
    [self.view addSubview:v];
    v.frame = CGRectMake(0, ScreenHeight-self.tabBar.yc_height, ScreenWith, self.tabBar.yc_height);
}

































- (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width/3, 49);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

- (UIImage *)drawTabBarItemBackgroundImageWithSize:(CGSize)size
{
    // 准备绘图环境
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 124.0 / 255, 124.0 / 255, 151.0 / 255, 1);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    // 获取该绘图中的图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束绘图
    UIGraphicsEndImageContext();
    
    /*
     // 获取当前应用路径中Documents目录下指定文件名对应的文件路径
     NSString *path = [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingString:@"/tabBarBackgroundImage.png"];
     NSLog(@"path:%@", path);
     // 保存PNG图片
     [UIImagePNGRepresentation(img) writeToFile:path atomically:YES];
     */
    return img;
}

//通过颜色来生成一个纯色图片
- (UIImage *)drawImageWithSize:(CGSize)size color:(UIColor *)color
{
    // 准备绘图环境
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    // 获取该绘图中的图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束绘图
    UIGraphicsEndImageContext();
    
    /*
     // 获取当前应用路径中Documents目录下指定文件名对应的文件路径
     NSString *path = [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingString:@"/tabBarBackgroundImage.png"];
     NSLog(@"path:%@", path);
     // 保存PNG图片
     [UIImagePNGRepresentation(img) writeToFile:path atomically:YES];
     */
    return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
