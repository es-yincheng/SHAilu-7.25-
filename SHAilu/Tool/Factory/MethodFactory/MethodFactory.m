//
//  MethodFactory.m
//  IBZApp
//
//  Created by 尹成 on 16/7/8.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "MethodFactory.h"

@implementation MethodFactory

- (void)saveUserInfo:(NSDictionary *)userInfo{
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
//    [userDefualts setValue:userInfo forKey:@"UserInfo"];
    [userDefualts setValue:@"info" forKey:@"UserInfo"];
    [userDefualts synchronize];
}

@end
