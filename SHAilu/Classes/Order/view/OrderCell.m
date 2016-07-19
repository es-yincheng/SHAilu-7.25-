//
//  OrderCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderCell.h"
#import "OrderDetail.h"

@interface OrderCell()

@property (weak, nonatomic) IBOutlet UIButton *orderButton;

@end

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _orderButton.layer.masksToBounds = YES;
    _orderButton.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

- (void)cellWithModel:(OrderModel *)model{
    
}

- (IBAction)orderDetailAction:(id)sender {
    OrderDetail *vc = [[OrderDetail alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
