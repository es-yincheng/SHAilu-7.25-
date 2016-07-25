//
//  PublishCell.m
//  IBZApp
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "PublishCell.h"

@implementation PublishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;

}

//-(void)configCellWithModel:(BaseModel *)model{
//    self.backgroundColor = [UIColor randomColor];
//}

@end
