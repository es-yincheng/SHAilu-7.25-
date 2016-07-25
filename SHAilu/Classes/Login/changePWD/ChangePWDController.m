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
    [sender countDown:10.0f];
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
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
