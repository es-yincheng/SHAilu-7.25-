//
//  OrderDetailController.m
//  SHAilu
//
//  Created by 尹成 on 16/8/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderDetailController.h"
#import "UIImageView+WebCache.h"

@interface OrderDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (weak, nonatomic) IBOutlet UILabel *specsLb;
@property (weak, nonatomic) IBOutlet UILabel *countLb;
@property (weak, nonatomic) IBOutlet UILabel *markLb;
@property (weak, nonatomic) IBOutlet UIImageView *upload1;
@property (weak, nonatomic) IBOutlet UIImageView *upload2;
@property (weak, nonatomic) IBOutlet UIImageView *upload3;
@property (weak, nonatomic) IBOutlet UIImageView *upload4;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
//    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[BaseAPI sharedAPI].orderService getOrderInfoWithOrderID:_orderID
                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                         NSLog(@"responseObject:%@",responseObject);
                                                         
                                                         if (1 == [[responseObject yc_objectForKey:@"Success"] integerValue]) {
                                                             NSDictionary *dict = [responseObject yc_objectForKey:@"Data"];
                                                             if (dict) {
                                                                 [self setUIWithDict:dict];
                                                             }
                                                         } else {
                                                             [MBProgressHUD showMessageAuto:[responseObject yc_objectForKey:@"ErrorMsg"]];
                                                         }
                                                         
                                                     } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUIWithDict:(NSDictionary *)dict{
    _countLb.text = [NSString stringWithFormat:@"%@",[[dict yc_objectForKey:@"Order"] yc_objectForKey:@"Count"]];
    _typeName.text = [[dict yc_objectForKey:@"Order"] yc_objectForKey:@"CategoryName"];
    _typeIcon.image = [UIImage imageNamed:[[dict yc_objectForKey:@"Order"] yc_objectForKey:@"CategoryImg"]];
    
    NSString *specsStr = @"";
    NSInteger x = 0;
    for (NSDictionary *temp in [dict yc_objectForKey:@"Spec"]) {
        NSString *str = [NSString stringWithFormat:@"第%ld层:%@、",(long)(x+1),[temp yc_objectForKey:@"Material"]];
        if ([temp yc_objectForKey:@"Thickness"]) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@μm",[temp yc_objectForKey:@"Thickness"]]];
        } else {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@g",[temp yc_objectForKey:@"Weight"]]];
        }
        
        if ([[dict yc_objectForKey:@"Spec"] count] != x + 1) {
            str = [str stringByAppendingString:@"\n"];
        }
        
        specsStr = [[specsStr mutableCopy] stringByAppendingString:str];
  
        x ++ ;
    }
    
    
    _specsLb.text = [NSString stringWithFormat:@"尺寸:%@*%@*%@mm\n%@",[[dict yc_objectForKey:@"Order"] yc_objectForKey:@"Length"],[[dict yc_objectForKey:@"Order"] yc_objectForKey:@"Width"],[[dict yc_objectForKey:@"Order"] yc_objectForKey:@"Height"],specsStr];
    _markLb.text = [[dict yc_objectForKey:@"Order"] yc_objectForKey:@"Remark"];
    
    NSInteger picIndex = 0;
    for (NSDictionary *imgDict in [dict yc_objectForKey:@"Images"]) {
        
        switch (picIndex) {
            case 0:
                [_upload1 sd_setImageWithURL:[NSURL URLWithString:[imgDict yc_objectForKey:@"ImgUrl"]]];
                break;
                
            case 1:
                [_upload2 sd_setImageWithURL:[NSURL URLWithString:[imgDict yc_objectForKey:@"ImgUrl"]]];
                break;
                
            case 2:
                [_upload3 sd_setImageWithURL:[NSURL URLWithString:[imgDict yc_objectForKey:@"ImgUrl"]]];
                break;
                
            case 3:
                [_upload4 sd_setImageWithURL:[NSURL URLWithString:[imgDict yc_objectForKey:@"ImgUrl"]]];
                break;
                
            default:
                break;
        }
        
        
        picIndex ++ ;
    }
}

@end
