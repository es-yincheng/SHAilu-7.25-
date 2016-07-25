//
//  MJDiyFooter.m
//  SHAilu
//
//  Created by 尹成 on 16/7/22.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "MJDiyFooter.h"

@implementation MJDiyFooter

- (void)prepare{
    [super prepare];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh0-%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.refreshingTitleHidden = YES;
//    self.stateLabel.hidden = YES;
    [self setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
}

@end
