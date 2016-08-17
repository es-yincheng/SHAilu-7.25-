//
//  SuccessController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/21.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SuccessController.h"
#import "FLAnimatedImage.h"

@interface SuccessController ()

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *successIcon;

@end

@implementation SuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成功";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    _successIcon.animatedImage = image;
    
    UIImage *backImage = [UIImage imageNamed:@"nav_back_white"];
    [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:backImage
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(okAction:)];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_successIcon startAnimating];
    [self performSelector:@selector(stopSuccess) withObject:nil afterDelay:3.0];
}

- (void)stopSuccess{
    [_successIcon stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)okAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
