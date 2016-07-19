//
//  TestLoginViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "TestLoginViewController.h"
//#import "YCLoginButton.h"
//#import "CustomButton.h"
#import "YCButton.h"

@interface TestLoginViewController ()

@end

@implementation TestLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YCCellLineColor;
    
    YCButton *button = [[YCButton alloc] initWithFrame:CGRectMake(40, 200, ScreenWith-80, 40) Type:YCButtonTypeDefault];
//    button.backgroundColor = [UIColor lightGrayColor];
    
    [button setTitle:@"测试按钮"];
//    [button setTitle:@"测试按钮" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
