//
//  Factory.m
//  IBZApp
//
//  Created by 尹成 on 16/7/8.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "Factory.h"

static UIFactory *uiFactory;
static MethodFactory *methodFactory;

@implementation Factory

+ (UIFactory *)sharedUI{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uiFactory = [[UIFactory alloc] init];
    });
    return uiFactory;
}

+ (MethodFactory *)sharedMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        methodFactory = [[MethodFactory alloc] init];
    });
    return methodFactory;
}


- (id)init
{
    self = [super init];
    if(self)
    {
//        _userService = [[UserService alloc] init];
//        _orderService = [[OrderService alloc] init];
//        _companyService = [[CompanyService alloc] init];
    }
    return (self);
}

@end
