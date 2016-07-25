////
////  YCPotosPickerViewController.m
////  YCPhotosPiker
////
////  Created by yc on 16/5/25.
////  Copyright © 2016年 yc. All rights reserved.
////
//
//#import "YCPotosPickerViewController.h" 
//#import "YCNoAuthorityViewController.h"
//#import "PhotoCell.h"
//#import "YCPhotoTool.h"
//#import "YCPhotoBrowser.h"
//
//typedef void (^handler)(NSArray<UIImage *> *selectPhotos);
//
//@interface YCPotosPickerViewController ()<UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPhotoLibraryChangeObserver ,UICollectionViewDataSource>
//{
////    YCPhotoTool *photoTool;
//}
//@end
//
//@implementation YCPotosPickerViewController
//
//-(instancetype)initWithGetPhotosBlock:(GetPhotosBlock)getPhotos{
//    self = [super init];
//    if (self) {
//        self.getPhotos = getPhotos;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
//    
////    photoTool = [[YCPhotoTool alloc] init];
//    
//    _maxSelectCount = 4;
//    _maxPreviewCount = 20;
//    _arrayDataSources  = [NSMutableArray array];
//    _arraySelectPhotos = [NSMutableArray array];
//    //注册实施监听相册变化
//    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
//    
//    
//    NSLog(@"----------------");
//    [self.view addSubview:self.collectionView];
//     NSLog(@"----------------");
//    
//    [self btnPhotoLibrary_Click];
//}
//
//
//#pragma mark － 自定义
//- (void)btnPhotoLibrary_Click
//{
//    if (![self judgeIsHavePhotoAblumAuthority]) {
//        //无相册访问权限
//        YCNoAuthorityViewController *nvc = [[YCNoAuthorityViewController alloc] init];
//        //        [self.sender.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromTop duration:0.25] forKey:nil];
//        //        [self.sender.navigationController pushViewController:nvc animated:NO];
//
//        [self.navigationController pushViewController:nvc animated:YES];
//    } else {
//        //        self.baseView.hidden = YES;
//        //        _animate = NO;
//        
//        YCPhotoBrowser *photoBrowser = [[YCPhotoBrowser alloc] initWithStyle:UITableViewStylePlain];
//        photoBrowser.maxSelectCount = self.maxSelectCount;
//        photoBrowser.arraySelectPhotos = _arraySelectPhotos.mutableCopy;
//        
//        //        __weak typeof(ZLPhotoActionSheet *) weakSelf = self;
//        [photoBrowser setDoneBlock:^(NSArray<YCSelectPhotoModel *> *selectPhotos) {
//            
//            
//            self.getPhotos(selectPhotos,self.maxSelectCount);
//            
//            
//            
//            ////            [_arraySelectPhotos removeAllObjects];
//            ////            [_arraySelectPhotos addObjectsFromArray:selectPhotos];
//            //
//            //
//            //            NSLog(@"我选择了图片：%@",_arraySelectPhotos);
//            //            for (YCSelectPhotoModel *model in _arraySelectPhotos) {
//            //                NSLog(@"图片名字：%@",model.imageName);
//            //            }
//            
//            
//            
//            //            [weakSelf done];
//            //            [weakSelf hide];
//        }];
//        [photoBrowser setCancelBlock:^{
//            NSLog(@"CancelBlock!");
//            //            [weakSelf hide];
//        }];
//        
//        //        [self.sender.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromTop duration:0.25] forKey:nil];
//        //        [self.sender.navigationController pushViewController:photoBrowser animated:NO];
////        [self.navigationController pushViewController:photoBrowser animated:YES];
//        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
//        [self.navigationController presentViewController:navigationVC animated:YES completion:nil];
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    
//}
//
//
//
//
//
//
//#pragma mark - 判断软件是否有相册、相机访问权限
//- (BOOL)judgeIsHavePhotoAblumAuthority
//{
//    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//    if (status == PHAuthorizationStatusRestricted ||
//        status == PHAuthorizationStatusDenied) {
//        return NO;
//    }
//    return YES;
//}
//
//
//
//
//
//
//
////- (void)loadPhotoFromAlbum
////{
////    [_arrayDataSources removeAllObjects];
////    [_arrayDataSources addObjectsFromArray:[photoTool getAllAssetInPhotoAblumWithAscending:NO]];
////    
////    [self.collectionView reloadData];
////}
////
////#pragma mark - 获取图片及图片尺寸的相关方法
////- (CGSize)getSizeWithAsset:(PHAsset *)asset
////{
////    CGFloat width  = (CGFloat)asset.pixelWidth;
////    CGFloat height = (CGFloat)asset.pixelHeight;
////    CGFloat scale = width/height;
////    
////    return CGSizeMake(self.collectionView.frame.size.height*scale, self.collectionView.frame.size.height);
////}
////
////- (void)getImageWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *image))completion
////{
////    CGSize size = [self getSizeWithAsset:asset];
////    size.width  *= 2;
////    size.height *= 2;
////    [photoTool requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:completion];
////}
////
////#pragma mark - delegate,datasouce
////-(void)photoLibraryDidChange:(PHChange *)changeInstance{
////    dispatch_sync(dispatch_get_main_queue(), ^{
////        [self loadPhotoFromAlbum];
////    });
////}
////
////#pragma mark - UICollectionDataSource
////- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
////{
////    return 1;
////}
////
////- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
////{
////    NSLog(@"row:%lu  inSection:%ld",(unsigned long)(self.maxPreviewCount>_arrayDataSources.count?_arrayDataSources.count:self.maxPreviewCount),(long)section);
////    return self.maxPreviewCount>_arrayDataSources.count?_arrayDataSources.count:self.maxPreviewCount;
////}
////
////- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
////{
////    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
////    
////    cell.btnSelect.selected = NO;
////    PHAsset *asset = _arrayDataSources[indexPath.row];
////    [self getImageWithAsset:asset completion:^(UIImage *image) {
////        cell.imageView.image = image;
////        for (YCSelectPhotoModel *model in _arraySelectPhotos) {
////            if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
////                cell.btnSelect.selected = YES;
////                break;
////            }
////        }
////    }];
////    
////    cell.btnSelect.tag = indexPath.row;
////    [cell.btnSelect addTarget:self action:@selector(cell_btn_Click:) forControlEvents:UIControlEventTouchUpInside];
////    
////    return cell;
////}
////
////#pragma mark - UICollectionViewDelegate
////- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
////{
////    PHAsset *asset = _arrayDataSources[indexPath.row];
////    return [self getSizeWithAsset:asset];
////}
////
////- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
////{
//////    ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
//////    svc.assets         = _arrayDataSources;
//////    svc.arraySelectPhotos = _arraySelectPhotos.mutableCopy;
//////    svc.selectIndex    = indexPath.row;
//////    svc.maxSelectCount = _maxSelectCount;
//////    svc.showPopAnimate = YES;
//////    svc.shouldReverseAssets = YES;
//////    __weak typeof(ZLPhotoActionSheet *) weakSelf = self;
//////    [svc setOnSelectedPhotos:^(NSArray<YCSelectPhotoModel *> *selectedPhotos) {
//////        [_arraySelectPhotos removeAllObjects];
//////        [_arraySelectPhotos addObjectsFromArray:selectedPhotos];
//////        [self changeBtnCameraTitle];
//////        [weakSelf.collectionView reloadData];
//////    }];
//////    [self.sender.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromTop duration:0.3] forKey:nil];
//////    [self.sender.navigationController pushViewController:svc animated:NO];
////}
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////#pragma mark - lazy
////-(UICollectionView *)collectionView{
////    if (!_collectionView) {
////        NSLog(@"添加collection");
////        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
////        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
////        layout.minimumInteritemSpacing = 3;
////        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
////        
////        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
////        _collectionView.backgroundColor = [UIColor blueColor];
////        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
////        _collectionView.delegate = self;
////        _collectionView.dataSource = self;
////    }
////    return _collectionView;
////}
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
////
//
//
//
//@end
