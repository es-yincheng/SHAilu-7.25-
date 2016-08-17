//
//  ChangePWDController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "ChangePWDController.h"

@interface ChangePWDController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *yzmField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation ChangePWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)sendYZMAction:(UIButton *)sender {
    if (![self.phoneField.text isPhoneNumber]) {
        return;
    }
    
    [[BaseAPI sharedAPI].userService getForgetPwdCheckCodeWithPhone:_phoneField.text
                                                               Pwd:nil
                                                         CheckCode:nil
                                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                               [UserModel yc_objectWithKeyValues:responseObject];
                                                               if (0 == [[responseObject yc_objectForKey:@"ErrorCode"] integerValue]) {
                                                                   [sender countDown:60.0f];
                                                               }
                                                               
                                                           } failure:nil];
}

- (IBAction)seePWDAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.pwdField.secureTextEntry = !sender.selected;
}

- (IBAction)changePwd:(id)sender {
    if (![self.phoneField.text isPhoneNumber]) {
        return;
    }
    if (![self.yzmField.text isYZM]) {
        return;
    }
    if (![self.pwdField.text isPWD]) {
        return;
    }
    [[BaseAPI sharedAPI].userService forgetPwdWithPhone:_phoneField.text
                                                    Pwd:_pwdField.text
                                              CheckCode:_yzmField.text
                                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                    
                                                    [UserModel yc_objectWithKeyValues:responseObject];
                                                    
                                                    if (0 == [[responseObject yc_objectForKey:@"ErrorCode"] integerValue]) {
//                                                        NSLog(@"找回密码：%@",[responseObject yc_objectForKey:@"ErrorMsg"]);
                                                        [MBProgressHUD showMessageAuto:@"重置密码成功,请重新登录"];
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                    }
                                                } failure:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
