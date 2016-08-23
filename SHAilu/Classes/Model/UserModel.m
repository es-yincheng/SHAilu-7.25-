//
//  UserModel.m
//  IBZApp
//
//  Created by 尹成 on 16/6/14.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (void)checkLoginStatu{
//    if ([UserModel getUserInfo]) {
//        UserModel *user = [UserModel getUserInfo];
//        [[BaseAPI sharedAPI].userService queryUserInfoWithUid:user.Uid
//                                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                             
//                                                          if ((0 != [[responseObject yc_objectForKey:@"ErrorCode"] intValue]) ||
//                                                              [responseObject yc_objectForKey:@"Data"] == nil ||
//                                                              ([responseObject yc_objectForKey:@"Data"] == [NSNull null])) {
//                                                              
//                                                              return;
//                                                          }
//                                                          
//                                                          
//                                                          UserModel *tempModel = [self mj_objectWithKeyValues:[responseObject yc_objectForKey:@"Data"] context:nil];
//                                                          if (tempModel) {
//                                                              [tempModel saveUserInfo];
//                                                          }
//                                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                                          
//                                                      }];
//    }
}

- (void)saveUserInfo{
    NSData *UserData = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:UserData forKey:@"UserData"];
    [defaults synchronize];
}

+ (UserModel *)getUserInfo{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"UserData"];
    
    if (!data) {
        return nil;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (instancetype)yc_objectWithKeyValues:(id)keyValues{
    
    if ((1 != [[keyValues yc_objectForKey:@"Success"] intValue])) {
//        ||
//        [keyValues yc_objectForKey:@"Data"] == nil ||
//        ([keyValues yc_objectForKey:@"Data"] == [NSNull null])
        [MBProgressHUD showMessageAuto:[NSString stringWithFormat:@"%@",[keyValues yc_objectForKey:@"ErrorMsg"]]];
        return nil;
    }
    
    return [self mj_objectWithKeyValues:[keyValues yc_objectForKey:@"Data"] context:nil];
}

//- (NSString *)UserName{
//
//    if (self.Mobile) {
//        return _UserName ? _UserName : [[NSString stringWithFormat:@"%@",self.Mobile] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//    }
//    return _UserName;
//}
//
//- (NSString *)getTureUserName{
//    return _UserName;
//}

@end
