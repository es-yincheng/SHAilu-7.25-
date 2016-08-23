//
//  SizeCell.m
//  SHAilu
//
//  Created by 尹成 on 16/8/15.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SizeCell.h"

@interface SizeCell()

@property (weak, nonatomic) IBOutlet UITextField *sizeLength;
@property (weak, nonatomic) IBOutlet UITextField *sizeWidth;
@property (weak, nonatomic) IBOutlet UITextField *sizeHeight;

@end

@implementation SizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSDictionary *)getDataDict{
    if (_sizeLength.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入长度"];
        return nil;
    }
    if ([_sizeLength.text integerValue] > 9999) {
        [MBProgressHUD showMessageAuto:@"长度上限为4位"];
        return nil;
    }
    if (_sizeWidth.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入宽度"];
        return nil;
    }
    if ([_sizeWidth.text integerValue] > 9999) {
        [MBProgressHUD showMessageAuto:@"宽度上限为4位"];
        return nil;
    }
    if (_sizeHeight.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入高度"];
        return nil;
    }
    if ([_sizeHeight.text integerValue] > 9999) {
        [MBProgressHUD showMessageAuto:@"高度上限为4位"];
        return nil;
    }
    
    NSDictionary *dict = @{@"width":_sizeWidth.text,
                           @"height":_sizeHeight.text,
                           @"length":_sizeLength.text};
    return dict;
}

@end
