//
//  OrderCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderCell.h"
//#import "OrderDetail.h"
#import "OrderDetailController.h"
#import "MessageController.h"
#import "DemoMessagesViewController.h"

typedef NS_ENUM(NSInteger, OrderStatus) {
    OrderStatusWaitPrice = 0,
    OrderStatusWaitStart,
    OrderStatusStart,
    OrderStatusFinish
};

@interface OrderCell(){
    OrderStatus orderStatus;
}

@property (weak, nonatomic) IBOutlet UILabel *statuLb;
@property (weak, nonatomic) IBOutlet UILabel *statuTime;
@property (weak, nonatomic) IBOutlet UIImageView *typePic;
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *sizeLb;
@property (weak, nonatomic) IBOutlet UILabel *plicsLb;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIView *buyView;

@end

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _orderButton.layer.masksToBounds = YES;
    _orderButton.layer.cornerRadius = 4;
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = 4;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)cellWithModel:(OrderModel *)model{
    
}

- (IBAction)buyAction:(id)sender {
    [self.viewController.view addSubview:self.buyView];
}

- (IBAction)orderDetailAction:(id)sender {

    
    
    OrderDetailController *vc = [[OrderDetailController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.viewController.tabBarController;
    tabBarController.customView.hidden = YES;
}

- (IBAction)messageAction:(id)sender {
    DemoMessagesViewController *vc = [[DemoMessagesViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.viewController.tabBarController;
    tabBarController.customView.hidden = YES;
}

- (UIView *)buyView{
    if (!_buyView) {
        
    }
    return _buyView;
}

- (void)configWithData:(id)data{
    orderStatus = [[data yc_objectForKey:@"status"] integerValue];
    
    switch (orderStatus) {
        case OrderStatusWaitPrice:
            NSLog(@"OrderStatusWaitPrice");
            
            _buyButton.hidden = YES;
            _orderButton.enabled = NO;
            _orderButton.backgroundColor = [UIColor lightGrayColor];
            
            break;
        case OrderStatusWaitStart:
            NSLog(@"OrderStatusWaitStart");
            
            _buyButton.hidden = YES;
            _orderButton.enabled = YES;
            _orderButton.selected = YES;
            _orderButton.backgroundColor = YCNavTitleColor;
            
            break;
        case OrderStatusStart:
            NSLog(@"OrderStatusStart");
            
            _buyButton.hidden = NO;
            _orderButton.enabled = YES;
            _orderButton.selected = NO;
            _orderButton.backgroundColor = YCNavTitleColor;
            
            break;
        case OrderStatusFinish:
            NSLog(@"OrderStatusFinish");
            
            _buyButton.hidden = NO;
            _orderButton.enabled = YES;
            _orderButton.selected = NO;
            _orderButton.backgroundColor = YCNavTitleColor;
            
            break;
            
        default:
            NSLog(@"default");
            break;
    }
    
    
    
    
//    @{@"statuName":@"您的订单已提交,等待"}
}

@end
