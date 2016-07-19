//
//  YCScrolPageCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCScrolPageCell.h"

@interface YCScrolPageCell()

@end

@implementation YCScrolPageCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 20;
        _button = [[YCButton alloc] initWithFrame:CGRectMake(40, self.mj_h - 60, self.mj_w - 2 * 40, 40) Type:YCButtonTypeDefault];
        [_button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

- (IBAction)testAction:(id)sender{
    NSLog(@"-----------------------");
}

- (void)buttonAction{
    NSLog(@"I select buttonAction!");
}

@end
