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

- (void)loginWithUserName:(NSString *)userName
                 Password:(NSString *)pwd
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

- (void)getRegisterCheckCodeWithPhone:(NSString *)phone
                                  Pwd:(NSString *)pwd
                            CheckCode:(NSString *)checkCode
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure;

- (void)registerWithPhone:(NSString *)phone
                      Pwd:(NSString *)pwd
                CheckCode:(NSString *)checkCode
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

- (void)getForgetPwdCheckCodeWithPhone:(NSString *)phone
                                    Pwd:(NSNumber *)pwd
                              CheckCode:(NSString *)checkCode
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure;

- (void)forgetPwdWithPhone:(NSString *)phone
                       Pwd:(NSString *)pwd
                 CheckCode:(NSString *)checkCode
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;

- (void)updatePwdWithPhone:(NSString *)phone
                    OldPwd:(NSString *)oldPwd
                       Pwd:(NSString *)pwd
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;

- (void)updateUserInfoWithUserName:(NSString *)userName
                            Mobile:(NSString *)userPhone
                               Sex:(NSNumber *)sex
                              Name:(NSString *)companyName
                         Telephone:(NSString *)companyPhone
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;

- (void)submitProposalWithMobile:(NSString *)userPhone
                         Content:(NSString *)Content
                         success:(SuccessBlock)success
                         failure:(FailureBlock)failure;

//- (void)queryContactInfoSuccess:(SuccessBlock)success Failure:(FailureBlock)failure;

//- (void)updateContactInfoWithEmail:(NSString *)email
//                             Phone:(NSString *)phone
//                              Name:(NSString *)name
//                                QQ:(NSString *)qq
//                               Sex:(Sex)sex
//                           Webchat:(NSString *)webchat
//                           success:(SuccessBlock)success
//                           failure:(FailureBlock)failure;

//- (void)queryCompanyInfoSuccess:(SuccessBlock)success Failure:(FailureBlock)failure;

//- (void)updateCompanyInfoWithName:(NSString *)name
//                       TelepPhone:(NSString *)telePhone
//                      MobilePhone:(NSString *)mobilePhone
//                          Address:(NSString *)address
//               MainBusinessRemark:(NSString *)mainBusinessRemark
//                      SalesIncome:(NSString *)salesIncome
//                      ProvinceUid:(NSString *)provinceUid
//                          CityUid:(NSString *)cityUid
//                          AreaUid:(NSString *)areaUid
//                          success:(SuccessBlock)success
//                          failure:(FailureBlock)failure;

@end
