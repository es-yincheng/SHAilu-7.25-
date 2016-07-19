//
//  YCLoginButton.m
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCLoginButton.h"

@implementation YCLoginButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    if (_touchBeginBlock) {
        _touchBeginBlock();
    }
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesMoved");
//}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");
    if (_touchEndedBlock) {
        _touchEndedBlock();
    }
}

//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesCancelled");
//}

@end
