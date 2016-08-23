//
//  UserService.m
//  IBZApp
//
//  Created by 尹成 on 16/6/12.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UserService.h"
#import "NetWorking.h"
#import "Security.h"

static NSString *LoginVerify            = @"Account/login";
static NSString *GetRegisterCheckCode   = @"Account/getRegisterCode";
static NSString *GetForgetPassCheckCode = @"Account/getPasswordCode";
static NSString *Register               = @"Account/register";
static NSString *ResetPwd               = @"Account/resetPassword";
static NSString *UpdatePwdAction        = @"Account/updatePassword";
static NSString *QueryUserInfo          = @"Account/getUserInfo";

@implementation UserService

- (void)queryUserInfoWithUid:(NSString *)Uid
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure{

    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [UserModel getUserInfo].Uid,@"userId",
                          [UserModel getUserInfo].Phone,@"phone",
                          nil];
    
    [[NetWorking sharedNetWorking] post:QueryUserInfo
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

-(void)loginWithUserName:(NSString *)userName
                Password:(NSString *)pwd
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          userName,@"phone",
                          [Security AesEncrypt:pwd],@"password",
                          nil];
    
    [[NetWorking sharedNetWorking] post:LoginVerify
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)getRegisterCheckCodeWithPhone:(NSString *)phone
                                  Pwd:(NSString *)pwd
                            CheckCode:(NSString *)checkCode
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"phone",
                          nil];
    
    [[NetWorking sharedNetWorking] post:GetRegisterCheckCode
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)registerWithPhone:(NSString *)phone
                     name:(NSString *)name
                      Pwd:(NSString *)pwd
              companyName:(NSString *)companyName
                CheckCode:(NSString *)checkCode
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"phone",
                          [Security AesEncrypt:pwd],@"password",
                          name,@"name",
                          companyName,@"companyName",
                          checkCode,@"code",
                          nil];
    
    [[NetWorking sharedNetWorking] post:Register
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)getForgetPwdCheckCodeWithPhone:(NSString *)phone
                                   Pwd:(NSString *)pwd
                             CheckCode:(NSString *)checkCode
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"phone",
                          nil];
    
    [[NetWorking sharedNetWorking] post:GetForgetPassCheckCode
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
    
}

- (void)forgetPwdWithPhone:(NSString *)phone
                       Pwd:(NSString *)pwd
                 CheckCode:(NSString *)checkCode
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"phone",
                          [Security AesEncrypt:pwd],@"password",
                          checkCode,@"code",
                          nil];
    
    [[NetWorking sharedNetWorking] post:ResetPwd
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)updatePwdWithOldPwd:(NSString *)oldPwd
                       Pwd:(NSString *)pwd
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [UserModel getUserInfo].Uid,@"Uid",
                          [UserModel getUserInfo].Phone,@"phone",
                         [Security AesEncrypt:oldPwd],@"oldPwd",
                            [Security AesEncrypt:pwd],@"password",
                          nil];
    
    [[NetWorking sharedNetWorking] post:UpdatePwdAction
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];

}

@end
