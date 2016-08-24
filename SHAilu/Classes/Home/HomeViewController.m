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
    
    UserModel *user = [UserModel getUserInfo];
    if (!user) {
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
            
//            [self.dataSource addObjectsFromArray:@[@"http://box.dwstatic.com/skin/Irelia/Irelia_0.jpg",
//                                                   @"http://box.dwstatic.com/skin/Irelia/Irelia_1.jpg",
//                                                   @"http://box.dwstatic.com/skin/Irelia/Irelia_2.jpg",
//                                                   @"http://box.dwstatic.com/skin/Irelia/Irelia_3.jpg"]];

            NSArray *images = @[@"category_1",
                                @"category_2",
                                @"category_3",
                                @"category_4",
                                @"category_5",
                                @"category_6"];
            NSArray *colors = @[[UIColor colorWithRed:0.957 green:0.843 blue:0.576 alpha:1.000],
                                [UIColor colorWithRed:0.961 green:0.773 blue:0.576 alpha:1.000],
                                [UIColor colorWithRed:0.953 green:0.804 blue:0.565 alpha:1.000],
                                [UIColor colorWithRed:0.914 green:0.725 blue:0.588 alpha:1.000],
                                [UIColor colorWithRed:0.933 green:0.827 blue:0.529 alpha:1.000],
                                [UIColor colorWithRed:0.922 green:0.851 blue:0.690 alpha:1.000]
                                ];
            
            NSArray *titles = @[@"阀口袋",
                                @"方底袋",
                                @"热封口袋",
                                @"缝底袋",
                                @"塑料阀口袋",
                                @"FFS膜"];
            
            NSArray *info = @[@"外阀式 · 内阀式",
                              @"方底袋",
                              @"M折边热封口袋 · 方底热封口袋",
                              @"缝底袋",
                              @"外阀式 · 内阀式",
                              @"单层重包装膜 · 双层铝塑重包装膜"];
            
            NSArray *descrip = @[@"广泛应用于化工、水泥、中成药、、助剂、食品等行业的粉状产品的包装，超大尺寸阀口袋背广泛应用于气相法白炭黑行业及超细纳米级粉料的包装，具有灌装方便，码垛，便于运输，美观大方的特点",
                                 @"开口方底袋又称开口糊底袋，在食品和添加剂行业是国外企业盛行的包装袋，采用传统方式灌装机械，装料后可以线缝合，堆垛整齐，美观",
                                 @"无缝纫，无污染，全密闭，防结块的特点；灌装和风口及其方便，适合大型流水线操作；灌装物料后袋基本成立方体，因垛包整齐、美观；属于环保纸袋，适合出口企业使用",
                                 @"一般为两边M折边，材料全部采用牛皮纸或者伸性纸，也可以是纸张和PE复合，从顶部直接进料灌装，罐装后口部需缝线闭合",
                                 @"广泛应用于化工、水泥、中成药、、助剂、食品等行业的粉状产品的包装，超大尺寸阀口袋背广泛应用于气相法白炭黑行业及超细纳米级粉料的包装，具有灌装方便，码垛，便于运输，美观大方的特点",
                                 @"该薄膜用于成型／灌装／封口一体化的生产方式，适合高速包装技术，包装效率高、成本低。应用于多种工业包装，尤其在聚乙烯、塑料粒子、合成树脂、饲料、肥料等包装领域"];
            
            
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:images,@"image",
                                  titles,@"title",
                                  info,@"info",
                                  descrip,@"descrip",
                                  colors,@"color",
                                  nil];

//            [self.dataSource addObjectsFromArray:@{@"image":images,
//                                                   @"title":titles,
//                                                   @"info":info,
//                                                   @"descrip":descrip}];
            
            
            
            self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - TBH - 40, ScreenWith, 30)];
            [self.view addSubview:_pageControl];
            _pageControl.numberOfPages = images.count;
            _pageControl.currentPageIndicatorTintColor = YCNavTitleColor;
            _pageControl.currentPage = 0;

            [_myScrollView loadWithData:dict];
            
//            [_myScrollView loadImagesWithUrl:self.dataSource colors:@[[UIColor colorWithRed:0.957 green:0.843 blue:0.576 alpha:1.000],
//                                                                      [UIColor colorWithRed:0.961 green:0.773 blue:0.576 alpha:1.000],
//                                                                      [UIColor colorWithRed:0.953 green:0.804 blue:0.565 alpha:1.000],
//                                                                      [UIColor colorWithRed:0.914 green:0.725 blue:0.588 alpha:1.000],
//                                                                      [UIColor colorWithRed:0.933 green:0.827 blue:0.529 alpha:1.000],
//                                                                      [UIColor colorWithRed:0.922 green:0.851 blue:0.690 alpha:1.000]
//                                                                      ]];
        });
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_imageView startAnimate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_imageView stopAnimate];
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

@end
