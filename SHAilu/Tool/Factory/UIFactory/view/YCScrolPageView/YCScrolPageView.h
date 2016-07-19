//
//  YCScrolPageView.h
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCScrolPageView : UIView


/**
 *  是否自动滚动
 *  是否循环滚动
 *  滚动模式：平滑（banner），缩放（艾路切换）
 *  是否显示页码（pageControl）
 */

- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target;

- (void)loadData:(NSArray *)data;

- (void)scroll;

@end
