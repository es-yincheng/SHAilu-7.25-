//
//  UITextField+Custom.m
//  IBZApp
//
//  Created by yc on 16/5/24.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UITextField+Custom.h"

@implementation UITextField (Custom)

-(BOOL)isTeleNumber{
    //手机号 或 座机
    NSString *tele = @"^(13|14|15|18|17)\\d{9}$)|(^0(([1,2]\\d)|([3-9]\\d{2}))\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tele];
    
    if ([regextestmobile evaluateWithObject:self.text]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isPhoneNumber{
    
    
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189,181(增加)
//     */
//    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189,181(增加)
//     22         */
//    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSString *moblie = @"^(13|14|15|18|17)\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moblie];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestmobile evaluateWithObject:self.text]) {
        return YES;
    }
    
    return NO;
    
    
//    NSString *pattern = @"^1+[3578]+\\d{9}";
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//    
//    BOOL isMatch = [pred evaluateWithObject:[NSString stringWithFormat:@"%@",self.text]];
//    
//    return isMatch;
}

-(BOOL)isPWD{
    NSString *pattern = @"^[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([pred evaluateWithObject:self.text]){
        return YES;
    }
    return NO;
}

-(BOOL)isYZM{
////    NSString *pattern = @"^[a-zA-Z0-9]{6,16}";
//    NSString *pattern = @"^[0-9]d{4}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    if ([pred evaluateWithObject:self.text]){
//        return YES;
//    }
//    return NO;
    if (self.text.length>3) {
        return YES;
    }
    return NO;

}



@end
