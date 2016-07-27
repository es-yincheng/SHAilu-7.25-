//
//  OrderDetailCell.h
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderText;
@property (weak, nonatomic) IBOutlet UILabel *buttonLine;
@property (weak, nonatomic) IBOutlet UILabel *centerLine;
@property (weak, nonatomic) IBOutlet UILabel *topLine;

@end
