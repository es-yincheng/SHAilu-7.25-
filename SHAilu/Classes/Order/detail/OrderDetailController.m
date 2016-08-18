//
//  OrderDetailController.m
//  SHAilu
//
//  Created by 尹成 on 16/8/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderDetailController.h"

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
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUI{
    self.title = @"订单详情";
    _typeName.text = @"热封口袋";
    _typeIcon.image = [UIImage imageNamed:@"category_4_1"];
    _specsLb.text = @"尺寸:200*300mm\n层数:3\n第一层:进口白色牛皮纸、70g";
    _markLb.text = @"备注加点啥好呢";
    _upload1.image = [UIImage imageNamed:@"category_3_1"];
    _upload2.image = [UIImage imageNamed:@"category_2_1"];
    _upload3.image = [UIImage imageNamed:@"bz_5"];
    _upload3.layer.cornerRadius;
}

@end
