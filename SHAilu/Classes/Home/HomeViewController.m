//
//  HomeViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "HomeViewController.h"
#import "MyScrollView.h"
#import "YGGravityImageView.h"

@interface HomeViewController ()<UIScrollViewDelegate>

//@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) YGGravityImageView *imageView;
@property (nonatomic, strong) MyScrollview *myScrollView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    YCTabBarController *tabBarController = (YCTabBarController*)self.tabBarController;
    tabBarController.customView.hidden = NO;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *hasUserInfo = [userDefault objectForKey:@"UserInfo"];
    if (!hasUserInfo) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
        UINavigationController *loginNV = [storyBoard instantiateViewControllerWithIdentifier:@"LoginNV"];
        [self.navigationController presentViewController:loginNV animated:NO completion:nil];
    } else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _imageView = [[YGGravityImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            _imageView.image = [UIImage imageNamed:@"backImage"];
            [self.view addSubview:_imageView];
            
            self.myScrollView = [[MyScrollview alloc] initWithFrame:self.view.bounds target:self];
            [self.view addSubview:_myScrollView];
            
            [self.dataSource addObjectsFromArray:@[@"http://box.dwstatic.com/skin/Irelia/Irelia_0.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_1.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_2.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_3.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_4.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_5.jpg"]];
            
            self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - TBH - 40, ScreenWith, 30)];
            [self.view addSubview:_pageControl];
            _pageControl.numberOfPages = self.dataSource.count;
            _pageControl.currentPageIndicatorTintColor = YCNavTitleColor;
            _pageControl.currentPage = 0;
            
            [_myScrollView loadImagesWithUrl:self.dataSource];
        });
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_imageView startAnimate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_imageView stopAnimate];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



#pragma mark - delegate
// scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/(620*ScreenWith/750.0);
}

// scrollView 的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_myScrollView scroll];
}


#pragma mark - lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

//- (FLAnimatedImageView *)backImageView{
//    if (!_backImageView) {
//        _backImageView = [[FLAnimatedImageView alloc] init];
//        _backImageView.frame = CGRectMake(0, 0, ScreenWith, ScreenHeight);
//        //得到图片的路径
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"testgif" ofType:@"gif"];
//        //将图片转为NSData
//        NSData *gifData = [NSData dataWithContentsOfFile:path];
//        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
//        _backImageView.animatedImage = image;
//    }
//    return _backImageView;
//}

@end
