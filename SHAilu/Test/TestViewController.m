//
//  TestViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "TestViewController.h"
#import "YCScrolPageView.h"

@interface TestViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) YCScrolPageView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
/**
 * 用来接收是第几张图
 **/
@property (nonatomic) NSUInteger x;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    // 创建imageView
//    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    //    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //    _imageView.clipsToBounds = YES;
//    [self.view addSubview:_imageView];
    
    
    // 创建自定义的scrollV
    self.scrollView = [[YCScrolPageView alloc] initWithFrame:self.view.bounds target:self];
    [self.view addSubview:_scrollView];
    
    // 创建辅助imageView
//    self.auxiliaryImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    NSArray *urlArray = @[@"http://box.dwstatic.com/skin/Irelia/Irelia_0.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_1.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_2.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_3.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_4.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_5.jpg"];
    
    [_scrollView loadData:urlArray];
//    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    [_scrollView addGestureRecognizer:_tap];
    
    
//    [_auxiliaryImageView sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[UIImage imageNamed:@"back"]];
//    [self performSelector:@selector(blur) withObject:nil afterDelay:0.2];
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWith, 30)];
    [self.view addSubview:_pageControl];
    _pageControl.backgroundColor = [UIColor lightGrayColor];
    _pageControl.numberOfPages = urlArray.count;
    _pageControl.currentPage = 0;

}

// scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     _x = scrollView.contentOffset.x / (ScreenWith * 2 / 3);
    _pageControl.currentPage = _x;
}


// scrollView 的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_scrollView scroll];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
