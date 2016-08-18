//
//  CardCell.h
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UIView

@property (weak, nonatomic) IBOutlet UIButton *orderBt;

@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *descrip;

- (void)configWithData:(NSDictionary *)data index:(NSInteger)index;

@end
