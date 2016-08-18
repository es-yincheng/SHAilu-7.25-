//
//  OrderStatusCell.h
//  SHAilu
//
//  Created by 尹成 on 16/8/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topLine;
@property (weak, nonatomic) IBOutlet UILabel *buttomLine;

- (void)configWithData:(id)data index:(NSInteger)index;

@end
