
//
//  YCNavigationController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/14.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCNavigationController.h"

@interface YCNavigationController ()

@end

@implementation YCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setNavigationItem{
    //color
    [self.navigationBar setBackgroundImage:[self drawImageWithSize:CGSizeMake(ScreenWith, 64) color:YCItemColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.backgroundColor = YCItemColor;
    
    //leftItem,rightItem color
    self.navigationBar.tintColor = YCNavTitleColor;
    
    //title color
    NSDictionary * dict = [NSDictionary dictionaryWithObject:YCNavTitleColor forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
    
    //statubar backcolor
    UIView *statusBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenWith, 20)];
    statusBackView.backgroundColor = YCItemColor;
    [self.navigationBar addSubview:statusBackView];
}

@end
