//
//  YCUserDefaults.h
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCUserDefaults : NSObject

- (void)saveUserInfo:(NSDictionary *)userInfo;
- (void)getUserInfo;
- (void)removeUserInfo;

@end
