//
//  YCUserDefaults.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCUserDefaults.h"

@implementation YCUserDefaults

- (void)saveUserInfo:(NSDictionary *)userInfo{
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
    [userDefualts setValue:userInfo forKey:@"UserInfo"];
    [userDefualts synchronize];
}

- (void)getUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:@"UserInfo"];
}

- (void)removeUserInfo{
    
}

@end
