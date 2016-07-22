//
//  YCViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCViewController.h"

@interface YCViewController ()

@end

@implementation YCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    [self setTabBarItem];
}

- (void)setNavigationItem{
    //color
    [self.navigationController.navigationBar setBackgroundImage:[self drawImageWithSize:CGSizeMake(ScreenWith, 64) color:YCItemColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = YCItemColor;
    
    //leftItem,rightItem color
    self.navigationController.navigationBar.tintColor = YCNavTitleColor;
    
    //title color
    NSDictionary * dict = [NSDictionary dictionaryWithObject:YCNavTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //statubar backcolor
    UIView *statusBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWith, 20)];
    statusBackView.backgroundColor = YCItemColor;
    [self.navigationController.navigationBar addSubview:statusBackView];
    
    UILabel *xline = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, ScreenWith, 0.5)];
    xline.backgroundColor = YCNavTitleColor;
    [self.navigationController.navigationBar addSubview:xline];
}

- (void)setTabBarItem{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
