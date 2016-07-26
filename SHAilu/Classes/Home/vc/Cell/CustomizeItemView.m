//
//  CustomizeItemView.m
//  SHAilu
//
//  Created by 尹成 on 16/7/26.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CustomizeItemView.h"
#import "CollectionViewCell.h"
#import "HeaderReusableView.h"

@interface CustomizeItemView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation CustomizeItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.dataArray addObjectsFromArray:@[@[@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a"],
                                              @[@"",@"",@"",@"",@"",@""],
                                              @[@"a",@"",@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a"]]];
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - action
- (IBAction)resetAction:(id)sender {
}

- (IBAction)submitAction:(id)sender {
}


#pragma mark - delegate/dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
//    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.dataArray yc_objectAtIndex:section] count];
//    return 5;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeaderReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
    
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    if ([self.selectArray[indexPath.section][indexPath.row] isEqualToString:@"b"]) {
        cell.layer.borderColor = YCNavTitleColor.CGColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = 0;
    for (NSString *str in self.selectArray[indexPath.section]) {
        
        if (index == indexPath.row) {
            self.selectArray[indexPath.section][indexPath.row] = @"b";
        } else {
            self.selectArray[indexPath.section][indexPath.row] = @"a";
        }
        index ++ ;
    }
    
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    
}

#pragma mark - lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.yc_width, 50);
        layout.itemSize = CGSizeMake((self.yc_width - 20)/3, 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc] init];
        [_selectArray addObjectsFromArray:self.dataArray];
    }
    return _selectArray;
}

@end
