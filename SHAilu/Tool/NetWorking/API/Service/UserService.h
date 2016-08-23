//
//  UserService.h
//  IBZApp
//
//  Created by 尹成 on 16/6/12.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

//typedef enum : NSUInteger {
//    Mr = 0,
//    Mrs,
//} Sex;

@interface UserService : BaseService

- (void)queryUserInfoWithUid:(NSString *)Uid
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure;

-(void)loginWithUserName:(NSString *)userName
                Password:(NSString *)pwd
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure;

- (void)getRegisterCheckCodeWithPhone:(NSString *)phone
                                  Pwd:(NSString *)pwd
                            CheckCode:(NSString *)checkCode
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure;

- (void)registerWithPhone:(NSString *)phone
                     name:(NSString *)name
                      Pwd:(NSString *)pwd
              companyName:(NSString *)companyName
                CheckCode:(NSString *)checkCode
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

- (void)getForgetPwdCheckCodeWithPhone:(NSString *)phone
                                   Pwd:(NSString *)pwd
                             CheckCode:(NSString *)checkCode
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure;

- (void)forgetPwdWithPhone:(NSString *)phone
                       Pwd:(NSString *)pwd
                 CheckCode:(NSString *)checkCode
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;

- (void)updatePwdWithOldPwd:(NSString *)oldPwd
                        Pwd:(NSString *)pwd
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure;

@end
