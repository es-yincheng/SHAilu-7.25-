//
//  YCScrolPageView.m
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCScrolPageView.h"
#import "YCScrolPageCell.h"

#define CellHeight self.frame.size.height
#define CellScaleHeight ScreenHeight - NVH - SBH - TBH - 40 - 80
#define CellButtonFrame CGRectMake(20, cell.yc_height - 70, cell.yc_width - 40, 35)


#define CellWidth ScreenWith * 2 / 3
#define CellScaleWidth ScreenWith*2/3


@interface YCScrolPageView()<UIScrollViewDelegate>{
    UIScrollView *scrollView;
}

@property (nonatomic, strong) NSMutableArray *cellsArray;

@end

@implementation YCScrolPageView

- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenWith/6, 0, ScreenWith*2/3, frame.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.clipsToBounds = NO;
        [self addSubview:scrollView];
        scrollView.delegate = target;
    }
    return self;
}

- (void)loadData:(NSArray *)data{
    NSArray *array = data;
    int index = 0;
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString * name in array){
        
        YCScrolPageCell *cell = [[YCScrolPageCell alloc] initWithFrame:CGRectMake(ScreenWith * 2 / 3 * index, 15, ScreenWith * 2 / 3, CellHeight)];
        cell.backgroundColor = [UIColor randomColor];
        cell.alpha = 0.8;
                if (index != 0) {
                    CGRect frame = cell.bounds;
                    frame.size.width =  ScreenWith * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * 1) )/ ScreenWith * 2 / 3 + 0.8 *ScreenWith * 2 / 3;
                    frame.size.height =  ScreenHeight * 2 / 3 * 0.2  * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * 1) )/ ScreenWith * 2 / 3 + 0.8 *ScreenHeight * 2 / 3;
                    cell.bounds = frame;
                    cell.button.frame = CellButtonFrame;
                }
        
        cell.contentMode = UIViewContentModeScaleToFill;
        [scrollView addSubview:cell];
        [self.cellsArray addObject:cell];
        cell.tag = index;
        
        index++;
    }
    scrollView.contentSize = CGSizeMake((scrollView.frame.size.width) * index, 0);
}

- (void)scroll{
    int index = scrollView.contentOffset.x / (ScreenWith * 2 / 3);
    if (index == 0) {
        for (int i = 0; i < 2; i++) {
            YCScrolPageCell *cell = _cellsArray[i];
            CGRect frame = cell.bounds;
            frame.size.width =  ScreenWith * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * i) )/ (ScreenWith * 2 / 3) + 0.8 * ScreenWith * 2 / 3;
            frame.size.height =  ScreenHeight * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * i) )/ (ScreenWith * 2 / 3) + 0.9 * ScreenHeight * 2 / 3;
            cell.bounds = frame;
            cell.button.frame = CellButtonFrame;
        }
    }else if(index == _cellsArray.count - 1){
        for (int i = index - 1; i < index + 1; i++) {
            YCScrolPageCell *cell = _cellsArray[i];
            CGRect frame = cell.bounds;
            frame.size.width =  ScreenWith * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * i) )/ (ScreenWith * 2 / 3) + 0.8 * ScreenWith * 2 / 3;
            frame.size.height =  ScreenHeight * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * i) )/ (ScreenWith * 2 / 3) + 0.9 * ScreenHeight * 2 / 3;
            cell.bounds = frame;
            cell.button.frame = CellButtonFrame;
        }
    }else{
        for (int i = index - 1; i < index + 2; i++) {
            YCScrolPageCell *cell = _cellsArray[i];
            CGRect frame = cell.bounds;
            frame.size.width =  ScreenWith * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * i) )/ (ScreenWith * 2 / 3) + 0.8 * ScreenWith * 2 / 3;
            frame.size.height =  ScreenHeight * 2 / 3 * 0.2 * (ScreenWith * 2 / 3 -  fabs(scrollView.contentOffset.x - ScreenWith * 2 / 3 * i) )/ (ScreenWith * 2 / 3) + 0.9 * ScreenHeight * 2 / 3;
            cell.bounds = frame;
            cell.button.frame = CellButtonFrame;
        }
    }
}


- (NSMutableArray *)cellsArray{
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray array];
    }
    return _cellsArray;
}

@end
