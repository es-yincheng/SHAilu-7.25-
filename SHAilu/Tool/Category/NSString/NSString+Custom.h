//
//  NSString+Custom.h
//  IBZApp
//
//  Created by 尹成 on 16/6/21.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Custom)

- (NSString *)md5;
- (NSString *)getTimeFromNow;
- (BOOL)isPhoneNumber;
- (BOOL)isPWD;
- (BOOL)isYZM;

@end
