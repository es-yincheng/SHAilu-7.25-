//
//  UIViewController+Custom.m
//  IBZApp
//
//  Created by 尹成 on 16/6/15.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UIViewController+Custom.h"
//#import "UserModel.h"

@implementation UIViewController (Custom)

- (void)logOut{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"UserData"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startLogin{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *loginNV = [storyBoard instantiateViewControllerWithIdentifier:@"LoginNV"];
        [self presentViewController:loginNV animated:YES completion:nil];
    });
}

- (void)startRegister{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];

        UIViewController *registerVC = [storyBoard instantiateViewControllerWithIdentifier:@"Register"];
//        UIViewController *registerVC = [storyBoard instantiateViewControllerWithIdentifier:@"Information"];
        
        UINavigationController *loginNV = [[UINavigationController alloc] initWithRootViewController:registerVC];
        [self presentViewController:loginNV animated:YES completion:nil];
    });
}

- (void)excueBlockAfterLogin:(void (^)())action{
//    if (![UserModel getUserInfo]) {
//        [self startLogin];
//        return;
//    }
//    action();
}

@end
