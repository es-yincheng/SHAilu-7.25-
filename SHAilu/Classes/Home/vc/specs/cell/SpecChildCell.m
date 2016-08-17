//
//  SpecChildCell.m
//  SHAilu
//
//  Created by 尹成 on 16/8/16.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SpecChildCell.h"

@implementation SpecChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:0.635 green:0.612 blue:0.600 alpha:1.000].CGColor;
}

@end
