//
//  BaseModel.m
//  IBZApp
//
//  Created by yc on 16/5/19.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "BaseModel.h"
#import "MJExtension.h"

@implementation BaseModel

MJCodingImplementation

+ (id)yc_objectWithKeyValues:(id)keyValues{
        
        if ((0 != [[keyValues yc_objectForKey:@"ErrorCode"] intValue]) ||
            [keyValues yc_objectForKey:@"Data"] == nil ||
            ([keyValues yc_objectForKey:@"Data"] == [NSNull null]) ) {
            
            [MBProgressHUD showMessageAuto:[NSString stringWithFormat:@"%@",[keyValues yc_objectForKey:@"ErrorMsg"]]];
            return nil;
        }
    
    return nil;
}

- (NSString *)description{

        NSMutableString* text = [NSMutableString stringWithFormat:@"<%@> \n", [self class]];
        NSArray* properties = [self filterPropertys];
        [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* key = (NSString*)obj;
            id value = [self valueForKey:key];
            NSString* valueDescription = (value)?[value description]:@"(null)";
            
            if ( ![value respondsToSelector:@selector(count)] && [valueDescription length]>60  ) {
                valueDescription = [NSString stringWithFormat:@"%@...", [valueDescription substringToIndex:59]];
            }
            valueDescription = [valueDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"\n   "];
            [text appendFormat:@"   [%@]: %@\n", key, valueDescription];
        }];
        [text appendFormat:@"</%@>", [self class]];;
        return text;
}

#pragma mark 获取一个类的属性列表
- (NSArray *)filterPropertys
{
    NSMutableArray* props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
        //        NSLog(@"name:%s",property_getName(property));
        //        NSLog(@"attributes:%s",property_getAttributes(property));
    }
    free(properties);
    return props;
}

@end
