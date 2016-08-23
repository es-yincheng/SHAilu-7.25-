//
//  SpecCell.m
//  SHAilu
//
//  Created by 尹成 on 16/8/16.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SpecCell.h"
#import "SpecChildCell.h"
#import "SelectCell.h"

#define SelectTableTag 3000
#define TitleViewHeight 42
#define CellSize CGSizeMake((ScreenWith-24-20-20)/3, TitleViewHeight)
#define OrignColor [UIColor colorWithRed:192/255.0f green:165/255.0f blue:104/255.0f alpha:1]
#define BoardColor [UIColor colorWithRed:0.635 green:0.612 blue:0.600 alpha:1.000]

NSString *SelectIdentifier = @"SelectWeight";

@interface SpecCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    NSInteger CellCount;
    NSArray *items;
    NSArray *weights;
    NSInteger lastClickCell;
    NSInteger lastWeight;
    UIView *backView;
    NSInteger cellType;
}

@property (weak, nonatomic  ) IBOutlet UIView                     *titleView;
@property (weak, nonatomic  ) IBOutlet UILabel                    *title;
@property (weak, nonatomic  ) IBOutlet UIImageView                *icon;
@property (weak, nonatomic  ) IBOutlet UILabel                    *materialLb;
@property (weak, nonatomic  ) IBOutlet UICollectionViewFlowLayout *layOut;
@property (weak, nonatomic  ) IBOutlet UICollectionView           *collection;
@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint         *collectionHeight;
@property (weak, nonatomic  ) IBOutlet UILabel                    *weight;
@property (weak, nonatomic  ) IBOutlet UIView                     *mainView;
@property (weak, nonatomic  ) IBOutlet UIView                     *fuView;
@property (weak, nonatomic  ) IBOutlet UIButton                   *weightButton;
@property (weak, nonatomic  ) IBOutlet UILabel                    *weightLb;
@property (weak, nonatomic  ) IBOutlet UILabel                    *typeTitle;
@property (weak, nonatomic) IBOutlet UITextField *thickness;
@property (nonatomic, strong) UITableView                         *weightTableView;

@end

@implementation SpecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _weightButton.layer.borderWidth = 1;
    _weightButton.layer.borderColor = BoardColor.CGColor;

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWith-20, TitleViewHeight) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = _titleView.bounds;
    maskLayer.path = maskPath.CGPath;
    _titleView.layer.mask = maskLayer;
    
    [self setCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setCollection{
    _layOut.itemSize = CellSize;
    
    [_collection registerNib:[UINib nibWithNibName:@"SpecChildCell" bundle:nil] forCellWithReuseIdentifier:@"SpecChildCell"];
    _collection.delegate   = self;
    _collection.dataSource = self;
    
    lastClickCell = 0;
    lastWeight = 0;
}


#pragma mark - custom
- (NSDictionary *)getDataDict{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (cellType == 1) {
        if (_thickness.text.length < 1 &&
            lastClickCell != 0) {
            //选择空 或者 必须输入 厚度
            [MBProgressHUD showMessageAuto:@"请输入材料厚度"];
            return nil;
        } else if(lastClickCell == 0){
            
        } else {
            [dict setValue:[items yc_objectAtIndex:lastClickCell] forKey:@"Material"];
            [dict setValue:[weights yc_objectAtIndex:lastWeight] forKey:@"Weight"];
            [dict setValue:_thickness.text forKey:@"Thickness"];
        }
    } else {
        [dict setValue:[items yc_objectAtIndex:lastClickCell] forKey:@"Material"];
        [dict setValue:[weights yc_objectAtIndex:lastWeight] forKey:@"Weight"];
        [dict setValue:_thickness.text forKey:@"Thickness"];
    }
    return dict;
}



#pragma mark - delegate\dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [items count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SpecChildCell *cell = [_collection dequeueReusableCellWithReuseIdentifier:@"SpecChildCell" forIndexPath:indexPath];
    
    cell.childLb.text = [items yc_objectAtIndex:indexPath.row];
    
    if (lastClickCell == indexPath.row) {
        cell.backgroundColor = YCNavTitleColor;
        cell.childLb.textColor = [UIColor whiteColor];
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
        scaleAnimation.springBounciness = 25.f;
        [cell.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    } else {
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.childLb.textColor = [UIColor lightGrayColor];
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        scaleAnimation.springBounciness = 0.f;
        [cell.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row != lastClickCell) {
        NSInteger last = lastClickCell;
        lastClickCell = indexPath.row;
        
        NSIndexPath *index1 = [NSIndexPath indexPathForRow:last inSection:0];
        NSIndexPath *index2 = [NSIndexPath indexPathForRow:lastClickCell inSection:0];
        [_collection reloadItemsAtIndexPaths:@[index1,index2]];
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [weights count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCell *cell = [_weightTableView dequeueReusableCellWithIdentifier:SelectIdentifier];
    cell.textLb.text = [NSString stringWithFormat:@"%@",[weights yc_objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    lastWeight = indexPath.row;
    _weightLb.text = [NSString stringWithFormat:@"%@ g",[weights yc_objectAtIndex:indexPath.row]];
    [self hiddenBackView];
}

#pragma mark - ovrride
- (void)configWithModel:(id)model{
    items = [model yc_objectForKey:@"material"];
    NSString *titleStr = [model yc_objectForKey:@"title"];
    _collectionHeight.constant = (CellSize.height+10) * ((items.count+2)/3)+10;
    [_collection reloadData];
    if ([[model yc_objectForKey:@"type"] isEqualToString:@"main"]) {
        weights = [model yc_objectForKey:@"weight"];
        self.mainView.hidden = NO;
        self.fuView.hidden = YES;
        self.weight.text = @"克重";
        self.title.text = [NSString stringWithFormat:@"第 %@ 层",titleStr];
        _typeTitle.text = @"材料A";
        cellType = 0;
    } else {
        self.mainView.hidden = YES;
        self.fuView.hidden = NO;
        self.weight.text = @"厚度";
        self.title.text = [NSString stringWithFormat:@"%@",titleStr];
        _typeTitle.text = @"材料B";
        cellType = 1;
    }
}

- (void)changeStatu:(CellStatu)statu{
    switch (statu) {
        case CellStatuOpen:
        {
            _titleView.backgroundColor = OrignColor;
            _title.textColor = [UIColor whiteColor];
            _icon.image = [UIImage imageNamed:@"specs_up"];
        }
            break;
            
        default:
        {
            _titleView.backgroundColor = [UIColor colorWithWhite:0.898 alpha:1.000];
            _title.textColor = YCBlackColor;
            _icon.image = [UIImage imageNamed:@"specs_down"];
        }
            break;
    }
}

- (IBAction)selectWeightAction:(id)sender {
    if (weights.count > 0) {
        //开始弹出克重选择框
        [[[UIApplication sharedApplication].windows lastObject] addSubview:self.weightTableView];
    } else {
        [MBProgressHUD showMessageAuto:@"若您能反馈此bug,我们将万分感谢"];
    }
}

- (void)hiddenBackView{
    [backView removeFromSuperview];
    [_weightTableView removeFromSuperview];
    backView = nil;
    _weightTableView = nil;
}

#pragma mark - lazy
- (UITableView *)weightTableView{
    if (!_weightTableView) {
        _weightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith-150, 40*weights.count)];
        _weightTableView.tag = SelectTableTag;
        _weightTableView.center = self.viewController.view.center;
        _weightTableView.delegate = self;
        _weightTableView.dataSource = self;
        [_weightTableView registerNib:[UINib nibWithNibName:@"SelectCell" bundle:nil] forCellReuseIdentifier:SelectIdentifier];
        _weightTableView.layer.masksToBounds = YES;
        _weightTableView.layer.cornerRadius = 8;
        
        
        backView = [[UIView alloc] initWithFrame:self.viewController.view.bounds];
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBackView)];
        [backView addGestureRecognizer:tap];
        backView.userInteractionEnabled = YES;
        [[[UIApplication sharedApplication].windows lastObject] addSubview:backView];
    }
    return _weightTableView;
}

- (void)dealloc{
    NSLog(@"你,你,你竟然敢杀我……");
}

@end
