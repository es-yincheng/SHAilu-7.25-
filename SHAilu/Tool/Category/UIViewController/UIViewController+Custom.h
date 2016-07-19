//
//  UIViewController+Custom.h
//  IBZApp
//
//  Created by 尹成 on 16/6/15.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Custom)

- (void)logOut;

- (void)startLogin;

- (void)startRegister;

- (void)excueBlockAfterLogin:(void (^)())action;

@end
