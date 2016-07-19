//
//  HomeViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#define TAG 99

#import "HomeViewController.h"
//#import "YCScrolPageView.h"
//#import "CardCollectionCell.h"
#import "RGCardViewLayout.h"
#import "RGCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) FLAnimatedImageView *backImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    [self.view insertSubview:self.backImageView belowSubview:self.collectionView];

    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - TBH - 40, ScreenWith, 30)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = 4;
    _pageControl.currentPage = 0;
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *hasUserInfo = [userDefault objectForKey:@"UserInfo"];
    if (!hasUserInfo) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
        UINavigationController *loginNV = [storyBoard instantiateViewControllerWithIdentifier:@"LoginNV"];
        [self.navigationController presentViewController:loginNV animated:NO completion:nil];
    } else {
//        [UIView animateWithDuration:60.f animations:^{
//            self.backImageView.frame = CGRectMake(-18.7*ScreenHeight/4.59+ScreenWith, 0, 18.7*ScreenHeight/4.59, ScreenHeight);
//        }completion:^(BOOL finished) {
//            
//        }];
    }
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//
- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
//
////// scrollView代理方法
////- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
////    _x = scrollView.contentOffset.x / (ScreenWith * 2 / 3);
////    _pageControl.currentPage = _x;
////}
//
//
////// scrollView 的代理方法
////- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    
////    [_scrollView scroll];
////}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//#pragma mark - custom
//
//
//
//#pragma mark - delegate/dataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return  4;
//}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CardCollectionCell *cell = (CardCollectionCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CardCollectionCell" forIndexPath:indexPath];
////    [self configureCell:cell withIndexPath:indexPath];
//    return cell;
//}
//
////- (void)configureCell:(RGCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
////{
////    UIView  *subview = [cell.contentView viewWithTag:TAG];
////    [subview removeFromSuperview];
////    
////    switch (indexPath.section) {
////        case 0:
////            cell.imageView.image =  [UIImage imageNamed:@"i1"];
////            cell.mainLabel.text = @"Glaciers";
////            break;
////        case 1:
////            cell.imageView.image =  [UIImage imageNamed:@"i2"];
////            cell.mainLabel.text = @"Parrots";
////            break;
////        case 2:
////            cell.imageView.image =  [UIImage imageNamed:@"i3"];
////            cell.mainLabel.text = @"Whales";
////            break;
////        case 3:
////            cell.imageView.image =  [UIImage imageNamed:@"i4"];
////            cell.mainLabel.text = @"Lake View";
////            break;
////        case 4:
////            cell.imageView.image =  [UIImage imageNamed:@"i5"];
////            break;
////        default:
////            break;
////    }
////    
////}
//
//
//
//
//#pragma mark - lazy
//
//- (UICollectionView *)collectionView{
//    if (!_collectionView) {
//        
//        RGCardViewLayout *layOut = [[RGCardViewLayout alloc] init];
//        
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layOut];
//        _collectionView.backgroundColor = [UIColor whiteColor];
//        [_collectionView registerNib:[UINib nibWithNibName:@"CardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CardCollectionCell"];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        [self.view addSubview:_collectionView];
//    }
//    return _collectionView;
//}
//
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGCollectionViewCell *cell = (RGCollectionViewCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(RGCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    UIView  *subview = [cell.contentView viewWithTag:TAG];
    [subview removeFromSuperview];
    
    switch (indexPath.section) {
        case 0:
            cell.imageView.image =  [UIImage imageNamed:@"i1"];
            cell.mainLabel.text = @"Glaciers";
            break;
        case 1:
            cell.imageView.image =  [UIImage imageNamed:@"i2"];
            cell.mainLabel.text = @"Parrots";
            break;
        case 2:
            cell.imageView.image =  [UIImage imageNamed:@"i3"];
            cell.mainLabel.text = @"Whales";
            break;
        case 3:
            cell.imageView.image =  [UIImage imageNamed:@"i4"];
            cell.mainLabel.text = @"Lake View";
            break;
        case 4:
            cell.imageView.image =  [UIImage imageNamed:@"i5"];
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = (long)roundf(scrollView.contentOffset.x/(scrollView.contentSize.width/4));
}

@end
