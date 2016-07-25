//
//  ChnagePwdController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "ChnagePwdController.h"

@interface ChnagePwdController ()

@property (weak, nonatomic) IBOutlet UITextField *nowPWD;
@property (weak, nonatomic) IBOutlet UITextField *changePwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@end

@implementation ChnagePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - action
- (IBAction)showPWDAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    _confirmPwd.secureTextEntry = !sender.selected;
}


- (IBAction)changePWDAction:(id)sender {
    if (![_nowPWD.text isPWD]) {
        return;
    }
    if (![_changePwd.text isPWD]) {
        return;
    }
    if (![_changePwd.text isPWD]) {
        return;
    }
    if (![_confirmPwd.text isEqualToString:_changePwd.text]) {
        [MBProgressHUD showMessageAuto:@"两次新密码不一致"];
        return;
    }
    [MBProgressHUD showMessageAuto:@"修改密码成功"];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
