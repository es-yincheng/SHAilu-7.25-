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

@interface CustomizeController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *typeLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *typeCollection;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *imageLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UITextField *countField;

@end

@implementation CustomizeController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setData];
    [self setCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - action
- (IBAction)selectSpecificationsAction:(id)sender {
    
}

- (IBAction)submitAction:(id)sender {
    SuccessController *vc = [[SuccessController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - delegate/dataSource
#pragma mark Collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 1000) {
//        NSInteger count = self.typeArray.count;
//        NSLog(@"self.typeArray.count:%lu",count);
//        return self.typeArray.count;
        
        return 11;
    }
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 1000) {
        TypeCell *cell = [_typeCollection dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
        
        return cell;
    }
    
    return [[UICollectionViewCell alloc] init];
}

#pragma mark - setData
- (void)setData{
    [self.typeArray addObjectsFromArray:@[@"a",@"b",@"d",@"",@"d"]];
}


#pragma mark - setUI
- (void)setCollection{
    _typeLayout.itemSize = CGSizeMake(_typeCollection.yc_width/3, _typeCollection.yc_height);
    [_typeCollection registerNib:[UINib nibWithNibName:@"TypeCell" bundle:nil] forCellWithReuseIdentifier:@"TypeCell"];
    _typeCollection.delegate = self;
    _typeCollection.dataSource = self;
}

#pragma mark - lazy
- (NSMutableArray *)typeArray{
    if (_typeArray) {
        _typeArray = [[NSMutableArray alloc] init];
    }
    return _typeArray;
}


@end
