//
//  NetWorking.h
//  IBZApp
//
//  Created by yc on 16/5/25.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

typedef void(^ProgressBlock)(NSProgress * _Nonnull uploadProgress);
typedef void(^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);


@interface NetWorking : NSObject

@property (nonatomic, strong) ProgressBlock _Nonnull progress;
@property (nonatomic, copy) SuccessBlock _Nonnull success;
@property (nonatomic, copy) FailureBlock _Nonnull failure;

+ (NetWorking *_Nonnull)sharedNetWorking;

-(void)post:(NSString *)method
 parameters:(NSDictionary *)parameters
   progress:(ProgressBlock)uploadProgress
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;

@end
