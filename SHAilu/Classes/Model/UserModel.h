//
//  UserModel.h
//  IBZApp
//
//  Created by 尹成 on 16/6/14.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "BaseModel.h"
#import "MJExtension.h"

@interface UserModel : BaseModel

@property (copy, nonatomic  ) NSString     *CompanyName;
@property (copy, nonatomic  ) NSString     *CompanyUid;
@property (strong, nonatomic) NSNumber     *Mobile;
@property (assign, nonatomic) NSNumber     *Sex;
@property (copy, nonatomic  ) NSString     *Uid;
@property (copy, nonatomic  ) NSString     *UserName;

- (void)saveUserInfo;

+ (UserModel *)getUserInfo;

+ (void)checkLoginStatu;

- (NSString *)UserName;

- (NSString *)getTureUserName;

@end
