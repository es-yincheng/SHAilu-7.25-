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
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation CustomizeItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self addSubview:self.resetButton];
        [self addSubview:self.submitButton];
        UILabel *xline = [[Factory sharedUI] getLineWithFrame:CGRectMake(0, self.yc_height-50, self.yc_width, 1) Direction:DirectionHorizontal];
        [self addSubview:xline];
    }
    return self;
}

#pragma mark - action
- (IBAction)resetAction:(id)sender {
    NSMutableArray *arry1 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a"]];
    NSMutableArray *arry2 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a",@"a",@"a"]];
    NSMutableArray *arry3 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a"]];
    _selectArray = [[NSMutableArray alloc] initWithObjects:arry1,arry2,arry3, nil];
    [_collectionView reloadData];
}

- (IBAction)submitAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HiddenCustomizItemView" object:nil];
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
        cell.title.layer.borderColor = YCNavTitleColor.CGColor;
    } else {
        cell.title.layer.borderColor = [UIColor colorWithWhite:0.941 alpha:1.000].CGColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableArray *sectionArray = [self.selectArray objectAtIndex:indexPath.section];
    
    for (NSInteger x = 0; x < [sectionArray count]; x++) {
        if (x == indexPath.row) {
            if ([sectionArray[x] isEqualToString:@"b"]) {
                [sectionArray replaceObjectAtIndex:indexPath.row withObject:@"a"];
            } else {
                [sectionArray replaceObjectAtIndex:indexPath.row withObject:@"b"];
            }
        } else {
            [sectionArray replaceObjectAtIndex:x withObject:@"a"];
        }
    }
    
    [self.selectArray replaceObjectAtIndex:indexPath.section withObject:sectionArray];
    
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    
}

#pragma mark - lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.yc_width, 50);
        layout.itemSize = CGSizeMake((self.yc_width - 50)/3, 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, self.yc_width-30, self.yc_height-50) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        
        NSMutableArray *arry1 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a"]];
        NSMutableArray *arry2 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a",@"a",@"a"]];
        NSMutableArray *arry3 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a"]];
        
        _dataArray = [[NSMutableArray alloc] initWithObjects:arry1,arry2,arry3, nil];
        
    }
    return _dataArray;
}

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        NSMutableArray *arry1 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a",@"a",@"a",@"a",@"a"]];
        NSMutableArray *arry2 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a",@"a",@"a"]];
        NSMutableArray *arry3 = [NSMutableArray arrayWithArray:@[@"a",@"a",@"a",@"a"]];
        
        _selectArray = [[NSMutableArray alloc] initWithObjects:arry1,arry2,arry3, nil];
    }
    return _selectArray;
}

- (UIButton *)resetButton{
    if (!_resetButton) {
        _resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.yc_height-50, self.yc_width/2, 50)];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:YCNavTitleColor forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] initWithFrame:CGRectMake(self.yc_width/2, self.yc_height-50, self.yc_width/2, 50)];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.backgroundColor = YCNavTitleColor;
        [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

@end
