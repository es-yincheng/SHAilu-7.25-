//
//  UIFont+Custom.m
//  IBZApp
//
//  Created by 尹成 on 16/6/28.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UIFont+Custom.h"

@implementation UIFont (Custom)

//设备型号
//#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
//#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
//#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
//#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
//#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )

////系统版本
//#define IS_IOS_VERSION   floorf([[UIDevice currentDevice].systemVersion floatValue]
//#define IS_IOS_5    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==5.0 ? 1 : 0
//#define IS_IOS_6    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==6.0 ? 1 : 0
//#define IS_IOS_7    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==7.0 ? 1 : 0
//#define IS_IOS_8    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==8.0 ? 1 : 0
//#define IS_IOS_9    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==9.0 ? 1 : 0

+ (UIFont *)yc_systemFontOfSize:(CGFloat)fontSize{
    if (IS_IPHONE_6_PLUS) {
        return [UIFont systemFontOfSize:fontSize * 1.5];
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)yc_boldSystemFontOfSize:(CGFloat)fontSize{
    if (IS_IPHONE_6_PLUS) {
        return [UIFont boldSystemFontOfSize:fontSize * 1.5];
    }
    return [UIFont boldSystemFontOfSize:fontSize];
}

@end
