//
//  CompanyService.m
//  IBZApp
//
//  Created by 尹成 on 16/6/23.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "CompanyService.h"

static NSString *GetCompanyShow = @"Home/GetCompanyShow";

@implementation CompanyService

- (void)getCompanyShowSuccess:(SuccessBlock)success
                      Failure:(FailureBlock)failure{
    
    [[NetWorking sharedNetWorking] post:GetCompanyShow
                             parameters:nil
                               progress:nil
                                success:success
                                failure:failure];
}

@end
