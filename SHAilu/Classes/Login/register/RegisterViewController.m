//
//  RegisterViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/19.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "RegisterViewController.h"
#import "YGGravityImageView.h"

@interface RegisterViewController ()

@property (strong, nonatomic) YGGravityImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *companyField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *yzmField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_nameField setValue:YCNavTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [_companyField setValue:YCNavTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneField setValue:YCNavTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [_yzmField setValue:YCNavTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [_pwdField setValue:YCNavTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    
    _nameField.textColor = [UIColor whiteColor];
    _companyField.textColor = [UIColor whiteColor];
    _phoneField.textColor = [UIColor whiteColor];
    _yzmField.textColor = [UIColor whiteColor];
    _pwdField.textColor = [UIColor whiteColor];
    
    _imageView = [[YGGravityImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.image = [UIImage imageNamed:@"backImage"];
    [self.view insertSubview:_imageView atIndex:0]; 
    self.view.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_imageView startAnimate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_imageView stopAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
- (BOOL)checkRegister{
    
    if (self.nameField.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入联系人姓名"];
        return NO;
    }
    if (self.companyField.text.length < 2) {
        [MBProgressHUD showMessageAuto:@"请慎入公司姓名"];
        return NO;
    }
    if (![self.phoneField.text isPhoneNumber]) {
        return NO;
    }
    if (![self.yzmField.text isYZM]) {
        return NO;
    }
    if (![self.phoneField.text isPWD]) {
        return NO;
    }
    return YES;
}

#pragma mark - action
- (IBAction)sendYZMAction:(UIButton *)sender {
    if (![self.phoneField.text isPhoneNumber]) {
        return;
    }
    [[BaseAPI sharedAPI].userService getRegisterCheckCodeWithPhone:_phoneField.text
                                                               Pwd:nil
                                                         CheckCode:nil
                                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                               [UserModel yc_objectWithKeyValues:responseObject];
                                                               if (0 == [[responseObject yc_objectForKey:@"ErrorCode"] integerValue]) {
                                                                   [sender countDown:60.0f];
                                                               }

                                                           } failure:nil];
}

- (IBAction)showPWDAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.pwdField.secureTextEntry = !sender.selected;
}


- (IBAction)registerAction:(id)sender {
    if (![self checkRegister]) {
        return;
    }
    
    [[BaseAPI sharedAPI].userService registerWithPhone:_phoneField.text
                                                   Pwd:_pwdField.text
                                             CheckCode:_yzmField.text
                                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                   
                                                   UserModel *userModel = [UserModel yc_objectWithKeyValues:responseObject];
                                                   if (userModel) {
                                                       [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                   }
                                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                   [MBProgressHUD showError:@"网络连接失败,请稍后重试"];
                                               }];
}

@end
