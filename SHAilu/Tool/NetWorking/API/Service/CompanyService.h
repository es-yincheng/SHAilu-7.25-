//
//  CompanyService.h
//  IBZApp
//
//  Created by 尹成 on 16/6/23.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "BaseService.h"

@interface CompanyService : BaseService

- (void)getCompanyShowSuccess:(SuccessBlock)success
                     Failure:(FailureBlock)failure;

@end
