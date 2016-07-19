//
//  BaseAPI.h
//  IBZApp
//
//  Created by yc on 16/5/20.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UserService.h"
//#import "OrderService.h"
//#import "CompanyService.h"
#import "ILService.h"

@interface BaseAPI : NSObject

@property (strong, nonatomic) ILService *ilService;
@property (strong, nonatomic) UserService    *userService;
//@property (strong, nonatomic) OrderService   *orderService;
//@property (strong, nonatomic) CompanyService *companyService;

+ (BaseAPI *)sharedAPI;
@end
