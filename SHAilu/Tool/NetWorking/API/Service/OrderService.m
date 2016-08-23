//
//  OrderService.m
//  IBZApp
//
//  Created by 尹成 on 16/6/18.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "OrderService.h"
//#import "UserModel.h"

static NSString *OrderOnline = @"Order/OrderOnline";
static NSString *GetOrders = @"Order/getOrders";
static NSString *GetOrderInfo = @"Order/getOrderInfo";
static NSString *OrderOnlineAgain = @"Order/orderOnlineAgain";
static NSString *GetOrderStatus = @"Order/getOrderStatus";


static NSString *GetPagePurchaseOrderItem = @"Order/GetPagePurchaseOrderItem";
static NSString *QuerySpotGoodsList       = @"Order/QuerySpotGoodsList";
static NSString *QuerySeekPurchaseList    = @"Order/QuerySeekPurchaseList";
static NSString *QueryCategory            = @"Order/QueryCategory";
static NSString *SubmitSupplyInfo         = @"Order/SubmitSupplyInfo";
static NSString *SubmitBuyInfo            = @"Order/SubmitBuyInfo";
static NSString *GetAreasBySpotGoodsData  = @"Order/GetAreasBySpotGoodsData";

@implementation OrderService

- (void)orderOnlineWithDict:(NSDictionary *)dict success:(SuccessBlock)success failure:(FailureBlock)failure{
    UserModel *userModel = [UserModel getUserInfo];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [param setValue:userModel.Uid forKey:@"UserUid"];
    
    [[NetWorking sharedNetWorking] post:OrderOnline
                             parameters:param
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)getOrdersWithPageIndex:(NSInteger)pageIndex success:(SuccessBlock)success failure:(FailureBlock)failure{
    UserModel *userModel = [UserModel getUserInfo];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:userModel.Uid forKey:@"UserUid"];
    [param setValue:@"10" forKey:@"pageSize"];
    [param setValue:[NSString stringWithFormat:@"%ld",(long)pageIndex] forKey:@"pageIndex"];
    
    [[NetWorking sharedNetWorking] post:GetOrders
                             parameters:param
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)getOrderInfoWithOrderID:(NSString *)orderID success:(SuccessBlock)success failure:(FailureBlock)failure{
    UserModel *userModel = [UserModel getUserInfo];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:userModel.Uid forKey:@"UserUid"];
    [param setValue:orderID forKey:@"OrderUid"];
    
    [[NetWorking sharedNetWorking] post:GetOrderInfo
                             parameters:param
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)orderOnlineAgainWithOrderID:(NSString *)orderID
                              count:(NSString *)count
                             remark:(NSString *)remark
                            success:(SuccessBlock)success
                            failure:(FailureBlock)failure{
    
    UserModel *userModel = [UserModel getUserInfo];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:userModel.Uid forKey:@"UserUid"];
    [param setValue:orderID forKey:@"OrderUid"];
    [param setValue:count forKey:@"count"];
    [param setValue:remark forKey:@"remark"];
    
    [[NetWorking sharedNetWorking] post:OrderOnlineAgain
                             parameters:param
                               progress:nil
                                success:success
                                failure:failure];
    
}

- (void)getOrderStatusWithOrderID:(NSString *)orderID success:(SuccessBlock)success failure:(FailureBlock)failure{
    UserModel *userModel = [UserModel getUserInfo];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:userModel.Uid forKey:@"UserUid"];
    [param setValue:orderID forKey:@"OrderUid"];
    
    [[NetWorking sharedNetWorking] post:GetOrderStatus
                             parameters:param
                               progress:nil
                                success:success
                                failure:failure];
}



















- (void)getPagePurchaseOrderItemWithPageIndex:(NSNumber *)pageIndex
                                      success:(SuccessBlock)success
                                      failure:(FailureBlock)failure{

    UserModel *userModel = [UserModel getUserInfo];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          userModel.Uid,@"Uid",
                          [NSString stringWithFormat:@"%@",pageIndex],@"PageIndex",
                          nil];
    
    [[NetWorking sharedNetWorking] post:GetPagePurchaseOrderItem
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)querySpotGoodsListWithPageIndex:(NSNumber *)pageIndex
                            CategoryUid:(NSString *)categoryUid
                              SortOrder:(NSString *)sortOrder
                             SortColumn:(NSString *)sortColumn
                                KeyWord:(NSString *)keyWord
                             CompanyUid:(NSString *)companyUid
                                AreaUid:(NSString *)areaUid
                               NotInUid:(NSString *)NotInUid
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure{
    
    UserModel *userModel = [UserModel getUserInfo];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:categoryUid forKey:@"CategoryUid"];
    [dict setValue:sortOrder forKey:@"SortOrder"];
    [dict setValue:sortColumn forKey:@"SortColumn"];
    [dict setValue:keyWord forKey:@"KeyWord"];
    [dict setValue:companyUid forKey:@"companyUid"];
    [dict setValue:areaUid forKey:@"areaUid"];
    [dict setValue:NotInUid forKey:@"NotInUid"];
    [dict setValue:userModel.Uid forKey:@"Uid"];
    [dict setValue:[NSString stringWithFormat:@"%@",pageIndex] forKey:@"PageIndex"];
//    [dict setValue:[NSString stringWithFormat:@"%d",5] forKey:@"PageSize"];
    
    NSLog(@"查询现货＋条件：\n%@",dict);
    
    [[NetWorking sharedNetWorking] post:QuerySpotGoodsList
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)querySeekPurchaseListWithPageIndex:(NSNumber *)pageIndex
                                   success:(SuccessBlock)success
                                   failure:(FailureBlock)failure{
//    UserModel *userModel = [UserModel getUserInfo];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"%@",pageIndex] forKey:@"PageIndex"];
    [[NetWorking sharedNetWorking] post:QuerySeekPurchaseList
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)queryCategoryWithParentUid:(NSString *)parentUid
                           success:(SuccessBlock)success
                           failure:(FailureBlock)failure{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:parentUid forKey:@"parentUid"];
    [[NetWorking sharedNetWorking] post:QueryCategory
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)submitSupplyInfoWithOrderUid:(NSString *)OrderUid
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure{
    UserModel *userModel = [UserModel getUserInfo];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:OrderUid forKey:@"OrderUid"];
    [dict setValue:userModel.Uid forKey:@"Uid"];
    [dict setValue:userModel.Phone forKey:@"phone"];
    
    NSLog(@"我要供货：%@",dict);
    NSLog(@"SubmitSupplyInfo:%@",SubmitSupplyInfo);
    
    [[NetWorking sharedNetWorking] post:SubmitSupplyInfo
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)submitBuyInfoWithOrderUid:(NSString *)Uid
                         Quantity:(NSString *)Quantity
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure{
 
    UserModel *userModel = [UserModel getUserInfo];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:Uid forKey:@"Uid"];
    [dict setValue:Quantity forKey:@"Quantity"];
    [dict setValue:userModel.Uid forKey:@"userUid"];
    [dict setValue:userModel.Phone forKey:@"phone"];
    [dict setValue:[userModel getTureUserName] forKey:@"UserName"];
    
    NSLog(@"委托订购：%@",dict);
    NSLog(@"SubmitBuyInfo:%@",SubmitBuyInfo);
    
    [[NetWorking sharedNetWorking] post:SubmitBuyInfo
                             parameters:dict
                               progress:nil
                                success:success
                                failure:failure];
}

- (void)getAreasBySpotGoodsDataSuccess:(SuccessBlock)success
                               Failure:(FailureBlock)failure{
    [[NetWorking sharedNetWorking] post:GetAreasBySpotGoodsData
                             parameters:nil
                               progress:nil
                                success:success
                                failure:failure];
}

@end
