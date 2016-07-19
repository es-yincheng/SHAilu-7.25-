//
//  UserService.m
//  IBZApp
//
//  Created by 尹成 on 16/6/12.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UserService.h"
#import "NetWorking.h"

static NSString *LoginVerify            = @"Account/LoginVerify";
static NSString *GetRegisterCheckCode   = @"Account/GetRegisterCheckCode";
static NSString *GetForgetPassCheckCode = @"Account/GetForgetPassCheckCode";
static NSString *Register               = @"Account/Register";
static NSString *ResetPwd               = @"Account/ResetPwd";
static NSString *UpdatePwdAction        = @"Account/UpdatePwdAction";
static NSString *UpdateUserInfo         = @"Account/UpdateUserInfo";
static NSString *SubmitProposal         = @"Home/SubmitProposal";


@implementation UserService

-(void)loginWithUserName:(NSString *)userName
                Password:(NSString *)pwd
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          userName,@"UserName",
                          pwd,@"Password",
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
                              phone,@"MobilePhone",
                                pwd,@"Password",
                                pwd,@"RePassword",
                          checkCode,@"RegisterCheckCode",
                                @"",@"Source",
                          nil];
    
    [[NetWorking sharedNetWorking] post:GetRegisterCheckCode
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)registerWithPhone:(NSString *)phone
                      Pwd:(NSString *)pwd
                CheckCode:(NSString *)checkCode
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"MobilePhone",
                          pwd,@"Password",
                          pwd,@"RePassword",
                          checkCode,@"RegisterCheckCode",
                          @"",@"Source",
                          nil];
    
    [[NetWorking sharedNetWorking] post:Register
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)getForgetPwdCheckCodeWithPhone:(NSString *)phone
                                   Pwd:(NSNumber *)pwd
                             CheckCode:(NSString *)checkCode
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"MobilePhone",
                          pwd,@"Password",
                          pwd,@"RePassword",
                          checkCode,@"ForgetPassCheckCode",
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
                          phone,@"MobilePhone",
                          pwd,@"Password",
                          pwd,@"RePassword",
                          checkCode,@"ForgetPassCheckCode",
                          nil];
    
    [[NetWorking sharedNetWorking] post:ResetPwd
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];

    
}

- (void)updatePwdWithPhone:(NSString *)phone
                    OldPwd:(NSString *)oldPwd
                       Pwd:(NSString *)pwd
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone,@"MobilePhone",
                         oldPwd,@"OldPassword",
                            pwd,@"Password",
                            pwd,@"RePassword",
                          nil];
    
    [[NetWorking sharedNetWorking] post:UpdatePwdAction
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];

}


- (void)updateUserInfoWithUserName:(NSString *)userName
                            Mobile:(NSString *)userPhone
                               Sex:(NSNumber *)sex
                              Name:(NSString *)companyName
                         Telephone:(NSString *)companyPhone
                           success:(SuccessBlock)success
                           failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          userName,@"UserName",
                          userPhone,@"Mobile",
                          sex,@"Sex",
                          companyName,@"Name",
                          companyPhone,@"Telephone",
                          nil];
    
    [[NetWorking sharedNetWorking] post:UpdateUserInfo
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)submitProposalWithMobile:(NSString *)userPhone
                         Content:(NSString *)Content
                         success:(SuccessBlock)success
                         failure:(FailureBlock)failure{
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          userPhone,@"Mobile",
                          Content,@"Content",
                          nil];
    
    [[NetWorking sharedNetWorking] post:SubmitProposal
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

@end
