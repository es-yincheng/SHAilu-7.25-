//
//  NSString+Custom.m
//  IBZApp
//
//  Created by 尹成 on 16/6/21.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "NSString+Custom.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Custom)

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSString *md5String = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5String;
}

- (BOOL)isPhoneNumber{
    NSString *moblie = @"^(13|14|15|18|17)\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", moblie];
    if ([regextestmobile evaluateWithObject:self]) {
        return YES;
    }
    [MBProgressHUD showMessageAuto:@"请输入正确的手机号"];
    return NO;
}

-(BOOL)isPWD{
    NSString *pattern = @"^[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([pred evaluateWithObject:self]){
        return YES;
    }
    
    [MBProgressHUD showMessageAuto:@"请输入6-16的位密码"];
    return NO;
}

-(BOOL)isYZM{
    if (self.length>3) {
        return YES;
    }
    [MBProgressHUD showMessageAuto:@"请输入验证码"];
    return NO;
    
}

- (NSString *)getTimeFromIBZService{
    NSString *time = [self substringWithRange:NSMakeRange(6, 10)];
    return [time getTimeForm1970];
}

- (NSString *)getTimeForm1970{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (NSString *)getTimeFromNow{
    
    NSString *time = [self substringWithRange:NSMakeRange(6, 10)];
    NSTimeInterval late = [time longLongValue];
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSString *timeString = @"";
    
    NSTimeInterval cha = now - late;
    
    if (cha/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分前", timeString];
        
    }
    if (cha/3600 > 1 && cha/86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400 > 1 && cha/(86400*30) < 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    if (cha/(86400*30) > 1)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY/MM/dd"];
        
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time longLongValue]];
        timeString = [formatter stringFromDate:confromTimesp];
    }
    return timeString;
}

@end
