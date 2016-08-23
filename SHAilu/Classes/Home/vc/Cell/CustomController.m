//
//  CustomController.m
//  SHAilu
//
//  Created by 尹成 on 16/8/8.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CustomController.h"
#import "SuccessController.h"
#import "TypeCell.h"
#import "PublishCell.h"
#import "AddCell.h"
#import "YCSelectPhotoModel.h"
#import "UIImageView+SelectPhoto.h"
#import <objc/runtime.h>
#import "SpecsController.h"
#import "SpecsTController.h"

static NSString *placeHolder = @"如有其它需求,请备注";

@interface CustomController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextViewDelegate>

@property (weak, nonatomic  ) IBOutlet UICollectionViewFlowLayout *typeLayout;
@property (weak, nonatomic  ) IBOutlet UICollectionView           *typeCollection;
@property (weak, nonatomic  ) IBOutlet UICollectionViewFlowLayout *imageLayout;
@property (weak, nonatomic  ) IBOutlet UICollectionView           *imageCollection;
@property (weak, nonatomic  ) IBOutlet UITextField                *countField;
@property (weak, nonatomic  ) IBOutlet UILabel                    *selectItems;
@property (weak, nonatomic  ) IBOutlet UITextView                 *markText;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *selectTypeArray;
@property (nonatomic, strong) MBProgressHUD  *hud;

@end

@implementation CustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.typeArray addObjectsFromArray:_startData];
    
    [self setCollection];
    _markText.layer.borderWidth = 1;
    _markText.layer.borderColor = YCCellLineColor.CGColor;
    _markText.text = placeHolder;
    _markText.textColor = [UIColor lightGrayColor];
    _markText.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_specsDict) {
        if ([_specsDict yc_objectForKey:@"material"]) {
            _selectItems.text = [NSString stringWithFormat:@"长宽:%@*%@*%@ mm ,层数:%lu 层",[_specsDict yc_objectForKey:@"length"],[_specsDict yc_objectForKey:@"width"],[_specsDict yc_objectForKey:@"height"],(unsigned long)[[_specsDict yc_objectForKey:@"material"] count]];
        }
    }
    
    NSLog(@"选中规格是:%@",_specsDict);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
-(void)dealWithSelectArray{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:self.imageArray];
    
    for (NSInteger x = (tempArray.count-1); x>=0; x--) {
        if (![[tempArray yc_objectAtIndex:x] isKindOfClass:([YCSelectPhotoModel class])]) {
            [tempArray removeObjectAtIndex:x];
        }
    }
    
    NSInteger arrayCout = 4 - (self.imageArray.count -1 - tempArray.count);
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%ld",(long)arrayCout],@"arrayCout",
                          tempArray,@"selectArray",
                          nil];
    
    NSNotification *notification = [NSNotification notificationWithName:@"dealWithSelectArray" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //    将过滤完的self。dataSource 和 原始数量传回去，做参数
}

-(IBAction)cancelSelectPhoto:(UIButton*)sender{
    [self.imageArray removeObjectAtIndex:sender.tag];
    [self dealWithSelectArray];
    [self.imageCollection reloadData];
}

#pragma mark - action
- (IBAction)selectSpecificationsAction:(id)sender {

    if (_startIndex == 4) {
        SpecsTController *vc = [[SpecsTController alloc] init];
        if (_specsDict) {
            vc.specsDict = _specsDict;
        }
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        SpecsController *vc = [[SpecsController alloc] init];
        if (_specsDict) {
            vc.specsDict = _specsDict;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)submitAction:(id)sender {
    
    if (![_specsDict yc_objectForKey:@"material"]) {
        [MBProgressHUD showMessageAuto:@"请选择规格"];
        return;
    }
    
    if (_countField.text.length < 1) {
        [MBProgressHUD showMessageAuto:@"请输入定制数量"];
        return;
    }
    
    NSString *categoryName;
    for (NSInteger x = 0; x < _selectTypeArray.count; x ++) {
        if ([self.selectTypeArray[x] isKindOfClass:[NSString class]] &&
            [self.selectTypeArray[x] isEqualToString:@"b"]) {
            categoryName = [[_typeArray yc_objectAtIndex:x] yc_objectForKey:@"title"];
        }
    }
    
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    [resultDict setValue:categoryName forKey:@"categoryName"];
    [resultDict setValue:_countField.text forKey:@"Count"];
    [resultDict setValue:_markText.text forKey:@"Remark"];
    [resultDict setValue:[_specsDict yc_objectForKey:@"height"] forKey:@"Height"];
    [resultDict setValue:[_specsDict yc_objectForKey:@"width"] forKey:@"Width"];
    [resultDict setValue:[_specsDict yc_objectForKey:@"length"] forKey:@"Length"];
    [resultDict setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[[_specsDict yc_objectForKey:@"material"] count]] forKey:@"Plies"];

    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:[[NSDictionary alloc] initWithObjectsAndKeys:[_specsDict yc_objectForKey:@"material"],@"Standard", nil] options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [resultDict setValue:json forKey:@"Spec"];
    NSLog(@"定制:%@",resultDict);
    
    
    [self askDataWithDict:resultDict];
    
    
    
    
    //如果有图片需要上传
//    self.hud.labelText = @"正在上传";
    
    
//    NSMutableArray *images = [[NSMutableArray alloc] init];
//    NSInteger imageCount = self.imageArray.count;
//    for (NSInteger x = self.imageArray.count-1; x >=0; x--) {
//        if ([[self.imageArray yc_objectAtIndex:x] isKindOfClass:[NSString class]]) {
//            imageCount = imageCount - 1;
//        } else {
//            UIImage *imageData;
//            if ([[self.imageArray yc_objectAtIndex:x] isKindOfClass:[YCSelectPhotoModel class]]) {
//                YCSelectPhotoModel *model = [self.imageArray yc_objectAtIndex:x];
//                
//                PHAsset *asset = model.asset;
//                // 是否要原图
//                CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
//                PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//                options.synchronous = YES;
//                // 从asset中获得图片
//                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                    
//                    [images addObject:result];
//                    
//                    if (images.count == imageCount) {
//                        [self dealImageArrayForUpload:images orther:resultDict];
//                    }
//                }];
//            } else {
//                imageData = [self.imageArray yc_objectAtIndex:x];
//                [images addObject:imageData];
//                if (images.count == imageCount) {
//                    [self dealImageArrayForUpload:images orther:resultDict];
//                }
//            }
//        }
//    }
}

- (void)dealImageArrayForUpload:(NSArray *)images orther:(NSMutableDictionary *)orhter{
//    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    NSMutableArray *resultImageArray = [[NSMutableArray alloc] init];
//    for (UIImage *image in images) {
//        dispatch_async(queue, ^{
//            [resultImageArray addObject:[image compressWithScale:0]];
//            NSLog(@"处理图片----%@",[NSThread currentThread]);
//            
//            if (resultImageArray.count == images.count) {
//                dispatch_sync(dispatch_get_main_queue(), ^{
                    UserModel *userModel = [UserModel getUserInfo];
//                    [orhter setValue:resultImageArray forKey:@"photo"];
                    [orhter setValue:userModel.Uid forKey:@"Uid"];

                    [self askDataWithDict:orhter];
                    
//                });
//            }
//        });
//    }
}

- (void)askDataWithDict:(NSDictionary*)orderDict{
    
    [[BaseAPI sharedAPI].orderService orderOnlineWithDict:orderDict
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                      [self.hud hide:YES];
                                                      self.hud = nil;
                                                      if ([[responseObject yc_objectForKey:@"Success"] integerValue] == 1) {
                                                          [self clearAllPublishData];
                                                          [MBProgressHUD showMessageAuto:@"定制成功"];
                                                          SuccessController *vc = [[SuccessController alloc] init];
                                                          [self.navigationController pushViewController:vc animated:YES];
                                                      } else {
                                                          [MBProgressHUD showMessageAuto:[responseObject yc_objectForKey:@"ErrorMsg"]];
                                                          [self.hud hide:YES];
                                                          self.hud = nil;
                                                      }
                                                  } failure:nil];
}

- (void)clearAllPublishData{
    [self.imageArray removeAllObjects];
    [self.imageArray addObject:@"add"];
    [self.imageCollection reloadData];
    _markText.text = placeHolder;
    _markText.textColor = [UIColor grayColor];
    [self dealWithSelectArray];
}


#pragma mark - delegate/dataSource
#pragma textView
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:placeHolder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = placeHolder;
        textView.textColor = [UIColor grayColor];
    }
}

#pragma mark Collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1000) {
        return [_typeArray count];
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 1000) {
        TypeCell *cell = [_typeCollection dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
        [cell configWithData:[_typeArray yc_objectAtIndex:indexPath.row]];
        if ([self.selectTypeArray[indexPath.row] isKindOfClass:[NSString class]] &&
            [self.selectTypeArray[indexPath.row] isEqualToString:@"b"]) {
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 8;
            cell.layer.borderColor = YCNavTitleColor.CGColor;
            cell.layer.borderWidth = 1;
            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
            scaleAnimation.springBounciness = 25.f;
            [cell.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
        } else {
            cell.layer.masksToBounds = NO;
            cell.layer.borderColor = [UIColor clearColor].CGColor;
            cell.layer.borderWidth = 1;
            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
            scaleAnimation.springBounciness = 25.f;
            [cell.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
        }
        return cell;
    }
    {
        if (indexPath.row == (self.imageArray.count - 1)) {
            AddCell *cell = [_imageCollection dequeueReusableCellWithReuseIdentifier:@"AddCell" forIndexPath:indexPath];
            cell.imageView.image = [UIImage imageNamed:@"publish_photo"];
            [cell.imageView selectPhotosWithTarget:self getPhotosFromAlbumBlock:^(NSArray<YCSelectPhotoModel *> *selectArray) {
                
                for (NSInteger x = (self.imageArray.count-2); x >= 0; x--) {
                    if ([[self.imageArray yc_objectAtIndex:x] isKindOfClass:([YCSelectPhotoModel class])]) {
                        NSLog(@"移除所有图库图片");
                        [self.imageArray removeObjectAtIndex:x];
                    }
                }
                NSLog(@"self.imageArray:%@",self.imageArray);
                [self.imageArray removeObjectAtIndex:self.imageArray.count-1];
                [self.imageArray addObjectsFromArray:selectArray];
                [self.imageArray addObject:@"add"];
                
                NSLog(@"返回后：%@",self.imageArray);
                [self.imageCollection reloadData];
            } FromCamera:^(UIImage *image) {
                [self.imageArray insertObject:image atIndex:self.imageArray.count-1];
                [self dealWithSelectArray];
                [self.imageCollection reloadData];
            }];
            return cell;
        } else if (indexPath.row > (_imageArray.count - 1)) {
            AddCell *cell = [_imageCollection dequeueReusableCellWithReuseIdentifier:@"PublishBackCell" forIndexPath:indexPath];
            cell.imageView.image = [UIImage imageNamed:@"publish_add"];
            return cell;
        }else {
            YCLog(@"cell for row at indexPath :%ld",(long)indexPath.row);
            PublishCell *cell = [_imageCollection dequeueReusableCellWithReuseIdentifier:@"PublishCell" forIndexPath:indexPath];
            
            if ([[self.imageArray yc_objectAtIndex:indexPath.row] isKindOfClass:([YCSelectPhotoModel class])]) {
                YCSelectPhotoModel *model = [self.imageArray yc_objectAtIndex:indexPath.row];
                cell.imageView.image = model.image;
            } else {
                NSLog(@"self.imageArray:%@ ,index:%ld",self.imageArray ,(long)indexPath.row);
                cell.imageView.image = [self.imageArray yc_objectAtIndex:indexPath.row];
            }
            cell.cancelBt.tag = indexPath.row;
            [cell.cancelBt addTarget:self action:@selector(cancelSelectPhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 1000) {
        
        for (NSInteger x = 0; x < self.selectTypeArray.count; x++) {
            if (x == indexPath.row) {
                [_selectTypeArray replaceObjectAtIndex:indexPath.row withObject:@"b"];
            } else {
                [_selectTypeArray replaceObjectAtIndex:x withObject:@"a"];
            }
        }
        [_typeCollection reloadData];
    }
}

#pragma mark - setData


#pragma mark - setUI
- (void)setCollection{
    _typeLayout.itemSize = CGSizeMake(_typeCollection.yc_width/3.5, _typeCollection.yc_height);
    [_typeCollection registerNib:[UINib nibWithNibName:@"TypeCell" bundle:nil] forCellWithReuseIdentifier:@"TypeCell"];
    _typeCollection.showsHorizontalScrollIndicator = NO;
    _typeCollection.delegate = self;
    _typeCollection.dataSource = self;
    
    _imageLayout.itemSize = CGSizeMake(ScreenWith/4, ScreenWith/4);
    [_imageCollection registerNib:[UINib nibWithNibName:@"PublishCell" bundle:nil] forCellWithReuseIdentifier:@"PublishCell"];
    [_imageCollection registerNib:[UINib nibWithNibName:@"AddCell" bundle:nil] forCellWithReuseIdentifier:@"AddCell"];
    [_imageCollection registerNib:[UINib nibWithNibName:@"AddCell" bundle:nil] forCellWithReuseIdentifier:@"PublishBackCell"];
    _imageCollection.scrollEnabled = NO;
    _imageCollection.delegate   = self;
    _imageCollection.dataSource = self;
}

#pragma mark - lazy
- (NSMutableArray *)selectTypeArray{
    if (!_selectTypeArray) {
        _selectTypeArray = [[NSMutableArray alloc] initWithArray:_typeArray];
        [_selectTypeArray replaceObjectAtIndex:0 withObject:@"b"];
    }
    return _selectTypeArray;
}

- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [[NSMutableArray alloc] init];
    }
    return _typeArray;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
        [_imageArray addObject:@"add"];
    }
    return _imageArray;
}

- (MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        _hud.labelText = @"";
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

@end
