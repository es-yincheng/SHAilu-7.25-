//
//  TestViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageViewTop;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 80, 53, 95)];
    _imageView.image = [UIImage imageNamed:@"start"];
    [self.view addSubview:_imageView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(200, 80, 53, 95)];
    _backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backView];
    _backView.clipsToBounds = YES;
    
    _imageViewTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 95)];
    _imageViewTop.image = [UIImage imageNamed:@"home"];
    [_backView addSubview:_imageViewTop];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(start) withObject:nil afterDelay:3.0f];
}

- (void)start{
//    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    spring.toValue = @(80+120);
//    spring.duration = 5.f;
//    [_backView.layer pop_addAnimation:spring forKey:@"aposition"];
//    
//    POPBasicAnimation *base = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    base.toValue = @(-120);
//    base.duration = 5.f;
//    [_imageViewTop.layer pop_addAnimation:base forKey:@"aposition"];


    [UIView animateWithDuration:4.0 // 动画时长
                     animations:^{
                         _backView.yc_y = 80 + 120;
                         _imageViewTop.yc_y =  - 120;
                     }];


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
