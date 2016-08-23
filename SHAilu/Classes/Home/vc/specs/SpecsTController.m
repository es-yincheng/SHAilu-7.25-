//
//  SpecsTController.m
//  SHAilu
//
//  Created by 尹成 on 16/8/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SpecsTController.h"
#import "CustomController.h"

@interface SpecsTController ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITextField *sizeLength;
@property (weak, nonatomic) IBOutlet UITextField *sizeWidth;
@property (weak, nonatomic) IBOutlet UITextField *sizeHeight;
@property (weak, nonatomic) IBOutlet UITextField *houduLb;

@end

@implementation SpecsTController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWith-20, 42) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    _titleView.layer.mask = maskLayer;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_specsDict) {
        if ([_specsDict yc_objectForKey:@"material"]) {
            _sizeWidth.text = [_specsDict yc_objectForKey:@"width"];
            _sizeLength.text = [_specsDict yc_objectForKey:@"length"];
            _sizeHeight.text = [_specsDict yc_objectForKey:@"height"];
            _houduLb.text = [[[_specsDict yc_objectForKey:@"material"] yc_objectAtIndex:0] yc_objectForKey:@"thickness"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okAction:(id)sender {
    if (_sizeLength.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入长度"];
        return;
    }
    if ([_sizeLength.text integerValue] > 99999) {
        [MBProgressHUD showMessageAuto:@"长度上限为4位"];
        return;
    }
    if (_sizeWidth.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入宽度"];
        return;
    }
    if ([_sizeWidth.text integerValue] > 99999) {
        [MBProgressHUD showMessageAuto:@"宽度上限为4位"];
        return;
    }
    if (_sizeHeight.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入高度"];
        return;
    }
    if ([_sizeHeight.text integerValue] > 9999) {
        [MBProgressHUD showMessageAuto:@"高度上限为4位"];
        return;
    }
    if (_houduLb.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入厚度"];
        return;
    }
    if ([_houduLb.text integerValue] > 99999) {
        [MBProgressHUD showMessageAuto:@"厚度上限为4位"];
        return;
    }
    
    CustomController *vc = [self.navigationController.viewControllers yc_objectAtIndex:1];
    
    vc.specsDict = @{@"height":_sizeHeight.text,
                     @"width":_sizeWidth.text,
                     @"length":_sizeLength.text,
                     @"material":@[@{@"materialId":@"123",@"thickness":_houduLb.text}]};
    [self.navigationController popViewControllerAnimated:YES];
}

@end
