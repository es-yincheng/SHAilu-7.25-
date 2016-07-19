
//
//  NetWorking.m
//  IBZApp
//
//  Created by yc on 16/5/25.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "NetWorking.h"
#import "AFHTTPSessionManager.h"

NSString *const NetworkReachabilityStatusUnknown          = @"Unknown";
NSString *const NetworkReachabilityStatusNotReachable     = @"NotReachable";
NSString *const NetworkReachabilityStatusReachableViaWWAN = @"WWAN ";
NSString *const NetworkReachabilityStatusReachableViaWiFi = @"Wifi";

static NetWorking *netWorking;
@implementation NetWorking
+ (NetWorking *)sharedNetWorking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorking = [[NetWorking alloc] init];
    });
    return netWorking;
}

+(void)startMonitoring{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"--------网络变动通知--------\n");
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [NetWorking sharedNetWorking].status = NetworkStatusUnknown;
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [NetWorking sharedNetWorking].status = NetworkStatusNotReachable;
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                [NetWorking sharedNetWorking].status = NetworkStatusReachableViaWWAN;
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                [NetWorking sharedNetWorking].status = NetworkStatusReachableViaWiFi;
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];

}









+ (NetworkStatus)getNetWorkStatuCode{
//    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    return [NetWorking sharedNetWorking].status;
}

+ (NSString*)getNetWorkStatuString{
    
   return [NSString stringWithFormat:@"%ld",(long)[[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus]];
    
    
    
    
    
    
    
//    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
//    switch (status) {
//        case AFNetworkReachabilityStatusUnknown:
//            return NetworkReachabilityStatusUnknown;
//            
//        case AFNetworkReachabilityStatusNotReachable:
//            return NetworkReachabilityStatusNotReachable;
//            
//        case AFNetworkReachabilityStatusReachableViaWWAN:
//            return NetworkReachabilityStatusReachableViaWWAN;
//            
//        case AFNetworkReachabilityStatusReachableViaWiFi:
//            return NetworkReachabilityStatusReachableViaWiFi;
//            
//        default:
//            return @"检测网络状态失败。";
//    }
}

-(void)get{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = @"http://192.168.0.170/Account/LoginVerify";
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}

-(void)post:(NSString *)method parameters:(NSDictionary *)parameters progress:(ProgressBlock)uploadProgress success:(SuccessBlock)success failure:(FailureBlock)failure{

//    UIActivityIndicatorView *busyView = [[UIActivityIndicatorView alloc] init];
//    busyView.center = [[UIApplication sharedApplication].delegate window].center;
//    [[[UIApplication sharedApplication].delegate window] addSubview:busyView];
////    busyView.backgroundColor = [UIColor lightGrayColor];
//    [busyView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
//    [busyView startAnimating];

    
   FLAnimatedImageView *busyView = [[FLAnimatedImageView alloc] init];
    busyView.bounds = CGRectMake(0, 0, 55, 55);
    busyView.center = [[UIApplication sharedApplication].delegate window].center;
    //得到图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testgif" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    busyView.animatedImage = image;
    [[[UIApplication sharedApplication].delegate window] addSubview:busyView];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseURL,method];
    
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"网络请求进度: %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [busyView stopAnimating];
        [busyView removeFromSuperview];
        if (success) {
            success(task, responseObject);
        } else {
            NSLog(@"统一处理成功数据：%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [busyView stopAnimating];
        [busyView removeFromSuperview];
        if (failure) {
            failure(task, error);
        } else {
            NSLog(@"error:%@",error);
            [MBProgressHUD showMessageAuto:@"网络连接失败，稍后再试"];
        }
    }];
}


/**
 *  AFN3.0 下载
 */
- (void)downLoad{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@""];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
        
    }];
    
    //开始启动任务
    [task resume];
    
}

/**
 *  AFN 3.0 上传
 *      有两种方式
 *          upLoad1 和 upLoad2
 */

//第一种方法是通过工程中的文件进行上传
- (void)upLoad1{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id  _Nonnull formData) {
        //上传文件参数
        UIImage *iamge = [UIImage imageNamed:@"123.png"];
        NSData *data = UIImagePNGRepresentation(iamge);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
    
}

//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
- (void)upLoda2{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.上传文件
    NSDictionary *dict = @{@"username":@"1234"};
    
    NSString *urlString = @"22222";
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id  _Nonnull formData) {
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}

@end
