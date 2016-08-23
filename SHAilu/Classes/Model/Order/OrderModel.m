//
//  OrderModel.m
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (NSMutableArray *)yc_objectWithKeyValues:(id)keyValues{
    if (1 != [[keyValues yc_objectForKey:@"Success"] intValue]) {
        [MBProgressHUD showMessageAuto:[NSString stringWithFormat:@"%@",[keyValues yc_objectForKey:@"ErrorMsg"]]];
        return nil;
    }
    
    NSArray *orders = [[keyValues yc_objectForKey:@"Data"] yc_objectForKey:@"Items"];
    return [self mj_objectArrayWithKeyValuesArray:orders context:nil];
}

@end
