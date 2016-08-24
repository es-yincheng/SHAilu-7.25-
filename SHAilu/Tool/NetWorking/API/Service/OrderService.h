//
//  OrderService.h
//  IBZApp
//
//  Created by 尹成 on 16/6/18.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "BaseService.h"

@interface OrderService : BaseService

- (void)orderOnlineWithDict:(NSDictionary *)dict
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure;

- (void)getOrdersWithPageIndex:(NSInteger)pageIndex
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure;

- (void)getOrderInfoWithOrderID:(NSString *)orderID
                        success:(SuccessBlock)success
                        failure:(FailureBlock)failure;

- (void)orderOnlineAgainWithOrderID:(NSString *)orderID
                              count:(NSString *)count
                             remark:(NSString *)remark
                            success:(SuccessBlock)success
                            failure:(FailureBlock)failure;

- (void)getOrderStatusWithOrderID:(NSString *)orderID
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure;

- (void)confirmOrderInfoWithOrderID:(NSString *)orderID
                            success:(SuccessBlock)success
                            failure:(FailureBlock)failure;

















- (void)getPagePurchaseOrderItemWithPageIndex:(NSNumber *)pageIndex
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure;

- (void)querySpotGoodsListWithPageIndex:(NSNumber *)pageIndex
                            CategoryUid:(NSString *)categoryUid
                              SortOrder:(NSString *)sortOrder
                             SortColumn:(NSString *)sortColumn
                                KeyWord:(NSString *)keyWord
                             CompanyUid:(NSString *)companyUid
                                AreaUid:(NSString *)areaUid
                               NotInUid:(NSString *)NotInUid
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure;

- (void)querySeekPurchaseListWithPageIndex:(NSNumber *)pageIndex
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure;

- (void)queryCategoryWithParentUid:(NSString *)parentUid
                                   success:(SuccessBlock)success
                                   failure:(FailureBlock)failure;

- (void)submitSupplyInfoWithOrderUid:(NSString *)OrderUid
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure;

- (void)submitBuyInfoWithOrderUid:(NSString *)Uid
                         Quantity:(NSString *)Quantity
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure;

- (void)getAreasBySpotGoodsDataSuccess:(SuccessBlock)success
                               Failure:(FailureBlock)failure;


@end
