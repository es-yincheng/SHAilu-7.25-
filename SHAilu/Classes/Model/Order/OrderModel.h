//
//  OrderModel.h
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (copy, nonatomic  ) NSString     *ParentCategoryName;
@property (copy, nonatomic  ) NSString     *CategoryName;
@property (copy, nonatomic  ) NSString     *CategoryImg;
@property (strong, nonatomic) NSNumber     *Count;
@property (copy, nonatomic  ) NSString     *CreateTime;
@property (copy, nonatomic  ) NSString     *Height;
@property (copy, nonatomic  ) NSString     *Length;
@property (strong, nonatomic) NSNumber     *Plies;
@property (copy, nonatomic  ) NSString     *Remark;
@property (copy, nonatomic  ) NSString     *Unit;
@property (copy, nonatomic  ) NSString     *Width;
@property (copy, nonatomic  ) NSString     *OrderUid;
@property (copy, nonatomic  ) NSString     *Uid;
@property (copy, nonatomic  ) NSString     *Status;

+ (NSMutableArray *)yc_objectWithKeyValues:(id)keyValues;

@end
