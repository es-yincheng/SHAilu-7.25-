//
//  YCBigImageCell.m
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import "YCBigImageCell.h"

@implementation YCBigImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)showIndicator
{
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
}

- (void)hideIndicator
{
    [self.indicator stopAnimating];
}

@end
