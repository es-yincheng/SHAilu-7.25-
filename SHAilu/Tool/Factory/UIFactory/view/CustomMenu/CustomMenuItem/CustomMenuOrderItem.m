//
//  CustomMenuOrderItem.m
//  IBZApp
//
//  Created by 尹成 on 16/7/11.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "CustomMenuOrderItem.h"

@implementation CustomMenuOrderItem

- (void)changeCustomStatu{
    
    switch (self.customStatu) {
        case CustomStatuNoarmal:
            self.customStatu = CustomStatuSelectedDown;
            [self setImage:[UIImage imageNamed:self.SelectedImageDown] forState:UIControlStateSelected];
            break;
            
        case CustomStatuSelectedDown:
            self.customStatu = CustomStatuSelectedUp;
            [self setImage:[UIImage imageNamed:self.SelectedImageUp] forState:UIControlStateSelected];
            break;
            
        case CustomStatuSelectedUp:
            self.customStatu = CustomStatuSelectedDown;
            [self setImage:[UIImage imageNamed:self.SelectedImageDown] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
}

@end
