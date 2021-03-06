//
//  OrderCell.h
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;

//- (void)cellWithModel:(OrderModel *)model;
- (void)configWithData:(id)data;

@end
