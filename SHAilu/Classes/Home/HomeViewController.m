//
//  HomeViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeViewController.h"
#import "YCScrolPageView.h"

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) YCScrolPageView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) FLAnimatedImageView *backImageView;
/**
 * 用来接收是第几张图
 **/
@property (nonatomic) NSUInteger x;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backImageView];
    
    // 创建自定义的scrollV
    self.scrollView = [[YCScrolPageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith, self.view.yc_height-NVH-TBH-SBH - 60) target:self];
    
    [self.view addSubview:_scrollView];
    
    NSArray *urlArray = @[@"http://box.dwstatic.com/skin/Irelia/Irelia_0.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_1.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_2.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_3.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_4.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_5.jpg"];
    
    [_scrollView loadData:urlArray];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - TBH - 30, ScreenWith, 30)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = urlArray.count;
    _pageControl.currentPage = 0;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSString *hasUserInfo = [userDefault objectForKey:@"UserInfo"];
//    if (!hasUserInfo) {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
//        UINavigationController *loginNV = [storyBoard instantiateViewControllerWithIdentifier:@"LoginNV"];
//        [self.navigationController presentViewController:loginNV animated:NO completion:nil];
//    } else {
////        [UIView animateWithDuration:60.f animations:^{
////            self.backImageView.frame = CGRectMake(-18.7*ScreenHeight/4.59+ScreenWith, 0, 18.7*ScreenHeight/4.59, ScreenHeight);
////        }completion:^(BOOL finished) {
////            
////        }];
//    }
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
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

#pragma mark - lazy
- (FLAnimatedImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[FLAnimatedImageView alloc] init];
        _backImageView.frame = CGRectMake(0, 0, ScreenWith, ScreenHeight);
        //得到图片的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"testgif" ofType:@"gif"];
        //将图片转为NSData
        NSData *gifData = [NSData dataWithContentsOfFile:path];
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
        _backImageView.animatedImage = image;
    }
    return _backImageView;
}

@end
