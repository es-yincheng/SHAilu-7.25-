//
//  TypeCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/21.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "TypeCell.h"

@interface TypeCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIImageView *childIcon;


@end

@implementation TypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.backgroundColor = [UIColor randomColor];
}

- (void)configWithData:(id)data{
    _childIcon.image = [UIImage imageNamed:[data yc_objectForKey:@"pic"]];
    _titleLb.text = [data yc_objectForKey:@"title"];
}

@end
