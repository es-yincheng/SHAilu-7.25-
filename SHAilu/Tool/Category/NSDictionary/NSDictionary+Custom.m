//
//  NSDictionary+Custom.m
//  IBZApp
//
//  Created by 尹成 on 16/6/27.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "NSDictionary+Custom.h"

@implementation NSDictionary (Custom)

- (id)yc_objectForKey:(id)aKey{
    return (([self objectForKey:aKey] == [NSNull null]) ? (nil) : ([self objectForKey:aKey]));
}

@end
