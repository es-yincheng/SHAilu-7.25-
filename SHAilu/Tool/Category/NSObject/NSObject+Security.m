//
//  NSObject+Security.m
//  SHAilu
//
//  Created by 尹成 on 16/8/19.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "NSObject+Security.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSObject (Security)

- (NSString *)getNativeToken{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    
    NSString *md5String = [NSMutableString stringWithString:[self md5:string]];
    NSInteger timeNumb = [[NSDate date] timeIntervalSince1970];
    NSMutableString *timeString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%ld",(long)timeNumb]];
    for (int x = 0; x<timeString.length; x++) {
        NSInteger timeIndex = ((timeNumb/(int)pow(10, x)*(int)pow(10, x))-(timeNumb/(int)pow(10, x+1))*(int)pow(10, x+1))/(int)pow(10, x);
        md5String = [md5String stringByReplacingCharactersInRange:NSMakeRange(x*3, 1)
                                                       withString:[NSString stringWithFormat:@"%ld",(long)timeIndex]];
    }
    return md5String;
}

- (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    NSString *md5String = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return md5String;
}

@end
