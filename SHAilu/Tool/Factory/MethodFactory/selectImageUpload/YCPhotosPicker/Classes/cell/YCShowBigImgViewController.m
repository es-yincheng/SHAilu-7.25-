//
//  YCShowBigImgViewController.m
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import "YCShowBigImgViewController.h"
#import "YCSelectPhotoModel.h"
#import "YCBigImageCell.h"
#import "YCPhotoTool.h"
#import "ToastUtils.h"

#define kViewWidth      [[UIScreen mainScreen] bounds].size.width
//如果项目中设置了导航条为不透明，即[UINavigationBar appearance].isTranslucent=NO，那么这里的kViewHeight需要-64
#define kViewHeight     [[UIScreen mainScreen] bounds].size.height-64

////////ZLPhotoActionSheet
#define kBaseViewHeight 300

////////ZLShowBigImgViewController
#define kItemMargin 30

@interface YCShowBigImgViewController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    
    NSMutableArray<PHAsset *> *_arrayDataSources;
    UIButton *_navRightBtn;
    //双击的scrollView
    UIScrollView *_selectScrollView;
    NSInteger _currentPage;
    YCPhotoTool *photoTool;
}

@end

@implementation YCShowBigImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    photoTool = [[YCPhotoTool alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //当前页
    
    NSLog(@"当前页面：%ld",(long)self.selectIndex);
    NSLog(@"当前选中页：%ld",(long)(self.assets.count-self.selectIndex));
    
    _currentPage = self.assets.count-self.selectIndex;
//    self.title = [NSString stringWithFormat:@"%ld/%ld", _currentPage, self.assets.count];
    self.title = [NSString stringWithFormat:@"%ld/%ld",(self.selectIndex+1),(unsigned long)self.assets.count];
    NSLog(@"初始化标题：%@",self.title);
    
    [self initNavBtns];
    [self sortAsset];
    [self initCollectionView];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.shouldReverseAssets) {
        
        
        
        
        
        [_collectionView setContentOffset:CGPointMake((self.assets.count-self.selectIndex-1)*([[UIScreen mainScreen] bounds].size.width), 0)];
    } else {
        [_collectionView setContentOffset:CGPointMake(self.selectIndex*([[UIScreen mainScreen] bounds].size.width), 0)];
    }
    
    [self changeNavRightBtnStatus];
}

- (void)initNavBtns
{
    //left nav btn
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(btnBack_Click)];
    
    //right nav btn
    _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _navRightBtn.frame = CGRectMake(0, 0, 25, 25);
    [_navRightBtn setBackgroundImage:[UIImage imageNamed:@"btn_circle.png"] forState:UIControlStateNormal];
    [_navRightBtn setBackgroundImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    [_navRightBtn addTarget:self action:@selector(navRightBtn_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navRightBtn];
}

#pragma mark - UIButton Actions
- (void)btnBack_Click
{
    if (self.onSelectedPhotos) {
        self.onSelectedPhotos(_arraySelectPhotos);
    }
    if (self.showPopAnimate) {
//        [self.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromBottom duration:0.3] forKey:nil];
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)navRightBtn_Click:(UIButton *)btn
{
    if (_arraySelectPhotos.count >= self.maxSelectCount
        && btn.selected == NO) {
        ShowToastLong(@"最多只能选择4张图片" );
//        NSLog(@"最多只能选择%ld张图片", self.maxSelectCount);
        return;
    }
    
    if (![self isHaveCurrentPageImage]) {
//        [btn.layer addAnimation:[ZLAnimationTool animateWithBtnStatusChanged] forKey:nil];
        
        PHAsset *asset = _arrayDataSources[_currentPage-1];
        YCSelectPhotoModel *model = [[YCSelectPhotoModel alloc] init];
        YCBigImageCell *cell = (YCBigImageCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentPage-1 inSection:0]];
        
        if (cell.imageView.image == nil) {
            ShowToastLong(@"图片加载中，请稍后");
//            NSLog(@"图片加载中，请稍后");
            return;
        }
        
        model.image = cell.imageView.image;
        model.imageName = [asset valueForKey:@"filename"];
        [_arraySelectPhotos addObject:model];
    } else {
        [self removeCurrentPageImage];
    }
    
    btn.selected = !btn.selected;
}

- (BOOL)isHaveCurrentPageImage
{
    
    
    
    PHAsset *asset = _arrayDataSources[_currentPage-1];
    for (YCSelectPhotoModel *model in _arraySelectPhotos) {
        if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
            return YES;
        }
    }
    return NO;
}

- (void)removeCurrentPageImage
{
    PHAsset *asset = _arrayDataSources[_currentPage-1];
    for (YCSelectPhotoModel *model in _arraySelectPhotos) {
        if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
            [_arraySelectPhotos removeObject:model];
            break;
        }
    }
}

- (void)changeNavRightBtnStatus
{
    if ([self isHaveCurrentPageImage]) {
        _navRightBtn.selected = YES;
    } else {
        _navRightBtn.selected = NO;
    }
}

- (void)sortAsset
{
    _arrayDataSources = [NSMutableArray array];
    if (self.shouldReverseAssets) {
        NSEnumerator *enumerator = [self.assets reverseObjectEnumerator];
        id obj;
        while (obj = [enumerator nextObject]) {
            [_arrayDataSources addObject:obj];
        }
    } else {
        [_arrayDataSources addObjectsFromArray:self.assets];
    }
}

#pragma mark - 初始化CollectionView
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
//    layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin/2, 0, kItemMargin/2);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = self.view.bounds.size;
    
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-kItemMargin/2, 0, kViewWidth+kItemMargin, kViewHeight) collectionViewLayout:layout];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:layout];
    
    
    _collectionView.backgroundColor = [UIColor orangeColor];
    
    
    
    
    
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YCBigImageCell" bundle:nil] forCellWithReuseIdentifier:@"YCBigImageCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;

    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrayDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCBigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YCBigImageCell" forIndexPath:indexPath];
    PHAsset *asset = _arrayDataSources[indexPath.row];
    
    cell.imageView.image = nil;
    [cell showIndicator];
    [photoTool requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *image) {
        cell.imageView.image = image;
        [cell hideIndicator];
    }];
    
    cell.scrollView.delegate = self;
    
    [self addDoubleTapOnScrollView:cell.scrollView];
    cell.backgroundColor = [self randomColor];
    return cell;
}

-(UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCBigImageCell *cell1 = (YCBigImageCell *)cell;
    cell1.scrollView.zoomScale = 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 图片缩放相关方法
- (void)addDoubleTapOnScrollView:(UIScrollView *)scrollView
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [scrollView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [scrollView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap
{
    if (self.navigationController.navigationBar.isHidden) {
        [self showStatusBarAndNavBar];
    } else {
        [self hidStatusBarAndNavBar];
    }
}

- (void)doubleTapAction:(UITapGestureRecognizer *)tap
{
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    _selectScrollView = scrollView;
    CGFloat scale = 1;
    if (scrollView.zoomScale != 3.0) {
        scale = 3;
    } else {
        scale = 1;
    }
    CGRect zoomRect = [self zoomRectForScale:scale withCenter:[tap locationInView:tap.view]];
    [scrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"-----------改变标题－－－－－－－－－：scrollViewDidScroll");
    if (scrollView == (UIScrollView *)_collectionView) {
        //改变导航标题
//        NSLog(@"x(%f)/w(%f) = (%f)",scrollView.contentOffset.x,[UIScreen mainScreen].bounds.size.width,scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width );
        CGFloat page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;

        NSString *str = [NSString stringWithFormat:@"%.0f", page];
        _currentPage = str.integerValue + 1;
        self.title = [NSString stringWithFormat:@"%ld/%ld", _currentPage, _arrayDataSources.count];
        [self changeNavRightBtnStatus];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = _selectScrollView.frame.size.height / scale;
    zoomRect.size.width  = _selectScrollView.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

#pragma mark - 显示隐藏导航条状态栏
- (void)showStatusBarAndNavBar
{
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)hidStatusBarAndNavBar
{
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
