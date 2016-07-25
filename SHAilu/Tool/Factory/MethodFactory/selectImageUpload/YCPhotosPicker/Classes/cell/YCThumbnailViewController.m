//
//  YCThumbnailViewController.m
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import "YCThumbnailViewController.h"
#import "YCPhotoTool.h"
#import "PhotoCell.h"
#import "YCShowBigImgViewController.h"
#import "ToastUtils.h"

@interface YCThumbnailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray<PHAsset *> *_arrayDataSources;
    
    BOOL _isLayoutOK;
    
    YCPhotoTool *photoTool;
}
@end

@implementation YCThumbnailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photoTool = [[YCPhotoTool alloc] init];
    
    _arrayDataSources = [NSMutableArray array];
    [self initNavBtn];
    [self initCollectionView];
    [self getAssetInAssetCollection];

}

//-(void)viewWillAppear:(BOOL)animated{
//    
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _isLayoutOK = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (!_isLayoutOK) {
        if (self.collectionView.contentSize.height > self.collectionView.frame.size.height) {
            [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height-self.collectionView.frame.size.height)];
        }
    }
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width-9)/4, ([[UIScreen mainScreen] bounds].size.width-9)/4);
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)getAssetInAssetCollection
{
    [_arrayDataSources addObjectsFromArray:[photoTool getAssetsInAssetCollection:self.assetCollection ascending:YES]];
    self.labCount.text = [NSString stringWithFormat:@"共%ld张照片", _arrayDataSources.count];
}

- (void)initNavBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    btn.titleLabel.font = [UIFont yc_systemFontOfSize:16];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtn_Click)];
}

#pragma mark - UIButton Action
- (void)cell_btn_Click:(UIButton *)btn
{
//    NSLog(@"选择该图片－－－－－－－－－－－－－－－－－－－－－－－－"); 
    if (!btn.selected && _arraySelectPhotos.count >= self.maxSelectCount) {
        ShowToastLong(@"最多只能选择4张图片");
//        NSLog(@"最多只能选择%ld张图片",self.maxSelectCount);
        return;
    }
    
    PHAsset *asset = _arrayDataSources[btn.tag];
    PhotoCell *cell = (PhotoCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    if (!btn.selected) {
        //添加图片到选中数组
//        [btn.layer addAnimation:[ZLAnimationTool animateWithBtnStatusChanged] forKey:nil];
        if (cell.imageView.image == nil) {
            ShowToastLong(@"该图片尚未从iCloud下载，请在系统相册中下载到本地后重新尝试，或在预览大图中加载完毕后选择");
//            NSLog(@"该图片尚未从iCloud下载，请在系统相册中下载到本地后重新尝试，或在预览大图中加载完毕后选择");
            return;
        }
        YCSelectPhotoModel *model = [[YCSelectPhotoModel alloc] init];
        model.image = cell.imageView.image;
        model.imageName = [asset valueForKey:@"filename"];
        
        [_arraySelectPhotos addObject:model];
        
         YCLog(@"选中图片，添加到 图片数组中 ： %@",_arraySelectPhotos);
    } else {
        YCLog(@"else");
        for (YCSelectPhotoModel *model in _arraySelectPhotos) {
            if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
                YCLog(@"取消选择后将 图片移除 数组！");
                [_arraySelectPhotos removeObject:model];
                break;
            }
        }
    }
    btn.selected = !btn.selected;
}

- (void)navLeftBtn_Click
{
    self.sender.arraySelectPhotos = self.arraySelectPhotos.mutableCopy;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightBtn_Click
{
    if (self.CancelBlock) {
        self.CancelBlock();
    }
//    [self.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromBottom duration:0.3] forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - UICollectionViewDataSource
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
    YCLog(@"cellForItemAtIndexPath 时 选中图片：%@",_arraySelectPhotos);
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    cell.btnSelect.selected = NO;
    PHAsset *asset = _arrayDataSources[indexPath.row];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    
    CGSize size = cell.frame.size;
    size.width *= 2;
    size.height *= 2;
    [photoTool requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image) {
        cell.imageView.image = image;
        for (YCSelectPhotoModel *model in _arraySelectPhotos) {
            if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
                cell.btnSelect.selected = YES;
                break;
            } else {
                cell.btnSelect.selected = NO;
            }
        }
    }];
    
    cell.btnSelect.tag = indexPath.row;
    [cell.btnSelect addTarget:self action:@selector(cell_btn_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCShowBigImgViewController *svc = [[YCShowBigImgViewController alloc] init];
    svc.assets         = _arrayDataSources;
    svc.arraySelectPhotos = self.arraySelectPhotos.mutableCopy;
    svc.selectIndex    = indexPath.row;
    svc.maxSelectCount = _maxSelectCount;
    svc.showPopAnimate = NO;
    svc.shouldReverseAssets = NO;
    __weak typeof(YCThumbnailViewController *) weakSelf = self;
    [svc setOnSelectedPhotos:^(NSArray<YCSelectPhotoModel *> *selectedPhotos) {
        [_arraySelectPhotos removeAllObjects];
        [_arraySelectPhotos addObjectsFromArray:selectedPhotos];
        [weakSelf.collectionView reloadData];
    }];
    
    [self.navigationController pushViewController:svc animated:YES];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnDone_Click:(id)sender {
    if (self.DoneBlock) {
        
        YCLog(@"我在 YCThumbnailViewController 中选择了（%@）个image ",self.arraySelectPhotos);
        
        
        self.DoneBlock(self.arraySelectPhotos);
    }
//    [self.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromBottom duration:0.3] forKey:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:NO];
}



@end
