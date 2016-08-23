
//
//  NetWorking.m
//  IBZApp
//
//  Created by yc on 16/5/25.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "NetWorking.h"
#import "AFHTTPSessionManager.h"
#import "UIImage+GIF.h"

static NetWorking *netWorking;
@implementation NetWorking
+ (NetWorking *)sharedNetWorking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorking = [[NetWorking alloc] init];
    });
    return netWorking;
}

-(void)post:(NSString *)method parameters:(NSDictionary *)parameters progress:(ProgressBlock)uploadProgress success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *tempToken = [self getNativeToken];
    [dict setValue:tempToken forKey:@"Token"];
    
    UIImageView *busyView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWith/2-35, ScreenHeight/2-100, 70, 70)];
    busyView.image = [UIImage sd_animatedGIFNamed:@"loading"];
    [[[UIApplication sharedApplication].delegate window] addSubview:busyView];
    [busyView startAnimating];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseURL,method];
    
    [manager POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"网络请求进度: %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ErrorMsg:%@",[responseObject yc_objectForKey:@"ErrorMsg"]);
        [busyView stopAnimating];
        [busyView removeFromSuperview];
        if (success) {
            success(task, responseObject);
        } else {
            NSLog(@"统一处理成功数据：%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [busyView stopAnimating];
        [busyView removeFromSuperview];
        if (failure) {
            failure(task, error);
        } else {
            [MBProgressHUD showMessageAuto:@"网络连接失败，稍后再试"];
        }
    }];
}

@end
