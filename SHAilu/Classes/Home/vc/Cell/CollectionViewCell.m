//
//  CollectionViewCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/26.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _title.layer.masksToBounds = YES;
    _title.layer.cornerRadius = 4;
    _title.layer.borderColor = [UIColor colorWithWhite:0.941 alpha:1.000].CGColor;
    _title.layer.borderWidth = 1;
}

@end
