
//
//  UIButton+Custom.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

- (void)countDown:(NSTimeInterval )time{
    {
        if (!time) {
            time = 60.0f;
        }
        __block int timeout = time;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
                    self.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 59;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                    self.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
}

@end
