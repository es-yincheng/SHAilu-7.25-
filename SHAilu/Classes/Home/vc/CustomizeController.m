//
//  CustomizeController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/21.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CustomizeController.h"
#import "SuccessController.h"
#import "TypeCell.h"
#import "PublishCell.h"
#import "AddCell.h"
#import "YCSelectPhotoModel.h"
#import "UIImageView+SelectPhoto.h"
#import <objc/runtime.h>
#import "CustomizeItemView.h"

#define CustomizeViewHeight ScreenWith*320/300
#define CustomizeCenterY (ScreenHeight - customizeViewHeight/2)

@interface CustomizeController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (weak, nonatomic  ) IBOutlet UICollectionViewFlowLayout *typeLayout;
@property (weak, nonatomic  ) IBOutlet UICollectionView           *typeCollection;
@property (weak, nonatomic  ) IBOutlet UICollectionViewFlowLayout *imageLayout;
@property (weak, nonatomic  ) IBOutlet UICollectionView           *imageCollection;
@property (weak, nonatomic  ) IBOutlet UITextField                *countField;
//@property (weak, nonatomic) IBOutlet UIButton *showItemsViewAction;
@property (weak, nonatomic  ) IBOutlet UILabel                    *selectItems;
@property (nonatomic, strong) NSMutableArray    *typeArray;
@property (nonatomic, strong) NSMutableArray    *imageArray;
@property (nonatomic, strong) NSMutableArray    *selectTypeArray;
@property (nonatomic, strong) UIView            *backView;
@property (nonatomic, strong) CustomizeItemView *customizeView;

@end

@implementation CustomizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制";
    [self setData];
    [self setCollection];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showSelectCustomizeItem:)
                                                 name:@"HiddenCustomizItemView"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.5);
    [self.backView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];

    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    spring.toValue = @(ScreenHeight - CustomizeViewHeight/2);
    spring.beginTime = CACurrentMediaTime();
    spring.springBounciness = 0.0f;
    [self.customizeView pop_addAnimation:spring forKey:@"aposition"];
}

- (IBAction)submitAction:(id)sender {
    SuccessController *vc = [[SuccessController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSelectCustomizeItem:(NSNotification *)notifaction{
    NSMutableArray *items = notifaction.object;
    
    NSInteger itemCount = 0;
    for (NSArray *temp in items) {
        for (NSString *temStr in temp) {
            if ([temStr isEqualToString:@"b"]) {
                itemCount ++;
            }
        }
    }
    
    _selectItems.text = [NSString stringWithFormat:@"选中了 %ld 个Item！",(long)itemCount];
    
    [self hiddenBackView];
}

- (void)hiddenBackView{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    spring.toValue = @(ScreenHeight + CustomizeViewHeight/2);
    spring.beginTime = CACurrentMediaTime();
    spring.springBounciness = 0.0f;
    [self.customizeView pop_addAnimation:spring forKey:@"aposition"];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0);
    [self.backView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

#pragma mark - delegate/dataSource
#pragma mark Collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1000) {
//        NSInteger count = self.typeArray.count;
//        NSLog(@"self.typeArray.count:%lu",count);
//        return self.typeArray.count
        return 6;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 1000) {
        TypeCell *cell = [_typeCollection dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
        cell.imageIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"bz_%ld",(long)(indexPath.row+1)]];
        if ([self.selectTypeArray[indexPath.row] isEqualToString:@"b"]) {
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
//            cell.layer.cornerRadius = 8;
            cell.layer.borderColor = [UIColor clearColor].CGColor;
            cell.layer.borderWidth = 1;
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
                NSLog(@"self.imageArray:%@ ,index:%ld",self.imageArray ,indexPath.row);
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
- (void)setData{
    [self.typeArray addObjectsFromArray:@[@"a",@"b",@"d",@"",@"d"]];
}


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
        _selectTypeArray = [[NSMutableArray alloc] initWithObjects:@"a",@"a",@"a",@"a",@"a",@"a", nil];
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

//@property (nonatomic, strong) UIView *backView;
//@property (nonatomic, strong) UIView *customizeView;

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        [self.view addSubview:_backView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBackView)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (CustomizeItemView *)customizeView{
    if (!_customizeView) {
        _customizeView = [[CustomizeItemView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWith, ScreenWith*320/300)];
//        _customizeView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_customizeView];
    }
    return _customizeView;
}

@end
