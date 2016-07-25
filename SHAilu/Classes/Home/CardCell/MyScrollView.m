//
//  MyScrollView.m
//  Test
//
//  Created by skma on 16/3/5.
//  Copyright © 2016年 skma. All rights reserved.
//

#import "MyScrollView.h"
#import "UIImageView+WebCache.h"
#import "CustomizeController.h"
#import "YCTabBarController.h"
#import "CardCell.h"
#import "YCNibManager.h"

#define ScrollViewFrame CGRectMake(65*ScreenWidth/750.0, 0, 620*ScreenWidth/750.0, self.frame.size.height)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

#define CellWidth ScrollViewFrame.size.width
#define CellHeight ScrollViewFrame.size.width*1000/620.0


#define CellInterval (620-30*2)/610.0

#define ButtonY (CellHeight - 65*CellInterval)

@interface MyScrollview () <UIScrollViewDelegate>

//@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
//@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation MyScrollview
{
    UIScrollView *scrollview;
}

- (NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        self.imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target{
    self = [super initWithFrame:frame];
    if (self){
        scrollview = [[UIScrollView alloc] initWithFrame:ScrollViewFrame];
        scrollview.backgroundColor = [UIColor clearColor];
        scrollview.pagingEnabled = YES;
        scrollview.clipsToBounds = NO;
        [self addSubview:scrollview];
        self.clipsToBounds = YES;
        // 添加代理
        scrollview.delegate = target;
    }
    return self;
}

- (IBAction)customAction:(id)sender{
    CustomizeController *vc = [[CustomizeController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.viewController.tabBarController;
    tabBarController.customView.hidden = YES;
}

// 加载网络图片
- (void)loadImagesWithUrl:(NSArray *)array{
    _picArray = array;
    int index = 0;
    [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString * name in array){
//        CardCell *iv = (CardCell *)[YCNibManager loadCardCell];
//        iv.frame = CGRectMake(CellWidth*index, self.frame.origin.y + 64 + 15, CellWidth, CellHeight);
        CardCell *iv = [[CardCell alloc] initWithFrame:CGRectMake(CellWidth*index, self.frame.origin.y + 64 + 15, CellWidth, CellHeight)];
        iv.frame = CGRectMake(CellWidth*index, self.frame.origin.y + 64 + 15, CellWidth, CellHeight);
        iv.typeIcon.layer.cornerRadius = CellWidth*3/5/2;
        iv.backgroundColor = [UIColor randomColor];

        iv.typeIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"bz_%d",index+1]];
        
        if (index != 0) {
            CGRect image = iv.bounds;
            image.size.width =  CellWidth * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * 1) )/ (CellWidth) + CellInterval * CellWidth;
            image.size.height =  CellHeight * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * 1) )/ (CellWidth) + CellInterval * CellHeight;
            iv.bounds = image;
            iv.typeIcon.layer.cornerRadius = image.size.width*3/5/2;
        }
        
        [scrollview addSubview:iv];
        [self.imageViewArray addObject:iv];
        iv.tag = index;
        
        index++;
    }
    scrollview.contentSize = CGSizeMake((scrollview.frame.size.width) * index, 0);
}

// 滚动时改变大小
#pragma <#arguments#>
- (void)scroll{
    int index = scrollview.contentOffset.x / CellWidth;
    if (index == 0) {
        for (int i = 0; i < 2; i++) {
            CardCell *im = _imageViewArray[i];
            CGRect image = im.bounds;
            image.size.width =  CellWidth * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * i) )/ (CellWidth) + CellInterval * CellWidth;
            image.size.height =  CellHeight * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * i) )/ (CellWidth) + CellInterval * CellHeight;
            im.bounds = image;
            
            im.typeIcon.layer.cornerRadius = image.size.width*3/5/2;
        }
    }else if(index == _picArray.count - 1){
        for (int i = index - 1; i < index + 1; i++) {
            CardCell *im = _imageViewArray[i];
            CGRect image = im.bounds;
            image.size.width =  CellWidth * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * i) )/ (CellWidth) + CellInterval * CellWidth;
            image.size.height =  CellHeight * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * i) )/ (CellWidth) + CellInterval * CellHeight;
            im.bounds = image;
            
            im.typeIcon.layer.cornerRadius = image.size.width*3/5/2;
        }
    }else{
        for (int i = index - 1; i < index + 2; i++) {
            CardCell *im = _imageViewArray[i];
            CGRect image = im.bounds;
            image.size.width =  CellWidth * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * i) )/ (CellWidth) + CellInterval * CellWidth;
            image.size.height =  CellHeight * (1-CellInterval) * (CellWidth -  fabs(scrollview.contentOffset.x - CellWidth * i) )/ (CellWidth) + CellInterval * CellHeight;
            im.bounds = image;
            im.typeIcon.layer.cornerRadius = image.size.width*3/5/2;
        }
    }
}

#pragma mark - lazy

//- (NSMutableArray *)buttonArray{
//    if (!_buttonArray) {
//        _buttonArray = [[NSMutableArray alloc] init];
//    }
//    return _buttonArray;
//}

@end

