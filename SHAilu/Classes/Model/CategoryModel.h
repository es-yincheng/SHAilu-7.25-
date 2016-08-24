//
//  CategoryModel.h
//  SHAilu
//
//  Created by 尹成 on 16/8/17.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryModel : BaseModel

+ (NSArray *)getChildCategoryById:(NSInteger)parentCategoryId;
+ (NSString *)getParentCategoryById:(NSInteger)parentCategoryId;
+ (NSDictionary *)getSpecs;

@end
