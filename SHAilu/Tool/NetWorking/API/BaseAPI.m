//
//  BaseAPI.m
//  IBZApp
//
//  Created by yc on 16/5/20.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "BaseAPI.h"

static BaseAPI *api;

@implementation BaseAPI
+ (BaseAPI *)sharedAPI{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[BaseAPI alloc] init];
    });
    return api;
}


- (id)init
{
    self = [super init];
    if(self)
    {
        _ilService = [[ILService alloc] init];
        _userService = [[UserService alloc] init];
        _orderService = [[OrderService alloc] init];
//        _companyService = [[CompanyService alloc] init];
    }
    return (self);
}
@end
