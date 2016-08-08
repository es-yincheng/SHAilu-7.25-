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

@interface OrderCell()

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
    MessageController *vc = [[MessageController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.viewController.tabBarController;
    tabBarController.customView.hidden = YES;
}

- (UIView *)buyView{
    if (!_buyView) {
        
    }
    return _buyView;
}

@end
