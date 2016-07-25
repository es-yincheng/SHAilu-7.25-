//
//  YCNoAuthorityViewController.m
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import "YCNoAuthorityViewController.h"

NSString *const PhotoNoAutority      = @"此应用程序没有权限访问您的照片";
NSString *const PhotoNoAutorityHint  = @"请在\"设置－隐私－图片\"中开启";
NSString *const AlbumNoAutority      = @"此应用程序没有权限访问您的照片";
NSString *const AlbumoNoAutorityHint = @"请在\"设置－隐私－图片\"中开启";
NSString *const AllNoAutority        = @"此应用程序没有权限访问您的照片";
NSString *const AllNoAutorityHint    = @"请在\"设置－隐私－图片\"中开启";

@interface YCNoAuthorityViewController ()

@end

@implementation YCNoAuthorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:[self drawImageWithSize:CGSizeMake(ScreenWith, 64) color:RGBCOLOR(216, 86, 77)] forBarMetrics:UIBarMetricsDefault];
    //左右按钮、文本颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //title 颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setAuthority:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
