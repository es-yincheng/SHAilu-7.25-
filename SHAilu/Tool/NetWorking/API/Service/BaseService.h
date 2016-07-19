//
//  BaseService.h
//  IBZApp
//
//  Created by 尹成 on 16/6/13.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ProgressBlock)(NSProgress * _Nonnull uploadProgress);
typedef void(^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@interface BaseService : NSObject

@property (nonatomic, strong) ProgressBlock _Nonnull progress;
@property (nonatomic, copy) SuccessBlock _Nonnull success;
@property (nonatomic, copy) FailureBlock _Nonnull failure;

@end
