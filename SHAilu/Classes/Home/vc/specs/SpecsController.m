//
//  SpecsController.m
//  SHAilu
//
//  Created by 尹成 on 16/8/15.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SpecsController.h"
#import "SizeCell.h"
//#import "SpecsCell.h"
#import "SpecCell.h"
#import "PliesCell.h"
#import "SelectCell.h"

NSString *SpecsCellIdentifier = @"SpecCell";
NSString *SizeCellIdentifier = @"SizeCell";
NSString *PliesCellIdentifier = @"PliesCell";
NSString *SelectCellIdentifier = @"SelectCell";
#define SelectTableTag 3000

@interface SpecsController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger cellCount;
    NSInteger lastClick;
    NSInteger pliesCount;
    NSInteger lastPlies;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *heights;
//@property (nonatomic, strong) NSArray *cellSatusArray;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *selectTable;
@property (nonatomic, weak) IBOutlet UIView *buttomView;

@end

@implementation SpecsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"规格";
    
    lastPlies = 2;
    [self.view addSubview:self.tableView];
    
    [[NSBundle mainBundle] loadNibNamed:@"SpecsToolBar" owner:self options:nil];
    _buttomView.frame = CGRectMake(0, ScreenHeight-49, ScreenWith, 49);
    [self.view addSubview:_buttomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    cellCount = 4;
    lastClick = 2;
    pliesCount = 4;
    [self.heights removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == SelectTableTag) {
        return pliesCount;
    } else {
        return cellCount;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == SelectTableTag) {
        return 40;
    } else {
        if (indexPath.row < 1) {
            return 80;
        }
        if (indexPath.row < 2) {
            return 60;
        }
        if (indexPath.row == lastClick) {
            return 390;
        }
        return 43;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == SelectTableTag) {
        SelectCell *cell = [_selectTable dequeueReusableCellWithIdentifier:SelectCellIdentifier];
        cell.textLb.text = [NSString stringWithFormat:@"%ld层",(long)indexPath.row+2];
        return cell;
    } else {
        switch (indexPath.row) {
            case 0:
            {
                SizeCell *cell = [_tableView dequeueReusableCellWithIdentifier:SizeCellIdentifier];
                
                
                return cell;
            }
                break;
                
            case 1:
            {
                PliesCell *cell = [_tableView dequeueReusableCellWithIdentifier:PliesCellIdentifier];
                cell.plicesLb.text = [NSString stringWithFormat:@"%ld",(long)lastPlies];
                return cell;
            }
                break;
                
            default:
            {
                SpecCell *cell = [_tableView dequeueReusableCellWithIdentifier:SpecsCellIdentifier];
//                cell.backgroundColor = [UIColor orangeColor];
                
                if (indexPath.row == lastClick) {
                    [cell changeStatu:CellStatuOpen];
                } else {
                    [cell changeStatu:CellStatuClose];
                }
                if (indexPath.row == cellCount-1) {
                    //辅料层
                    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"auxliary",@"type",
                                          @[@"无",@"LDPE",@"HDPE",@"7层共挤高阻隔膜"],@"material",
                                          @"材料B",@"title",
                                          nil];
                    [cell configWithModel:dict];
                } else {
                    //主料层
                    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @"main",@"type",
                                          @[@"进口白色牛皮纸",@"进口本色牛皮纸",@"国产本色牛皮纸",@"进口白色伸性纸",@"进口本色伸性纸",@"国产本色伸性纸",@"进口白色高透伸性纸",@"进口本色高透伸性纸",@"淋膜",@"纸铝复合材料"],@"material",
                                          @[@70,@75,@80,@90,@100,@125],@"weight",
                                          [NSString stringWithFormat:@"%ld",indexPath.row-1],@"title",
                                          nil];
                    [cell configWithModel:dict];
                }
                return cell;
            }
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == SelectTableTag) {
        NSLog(@"indexPath:%ld",(long)indexPath.row);
        
        NSInteger plies = indexPath.row+2 - lastPlies;
        NSInteger lPlies = lastPlies;
        
        lastPlies = indexPath.row+2;
        [self hiddenBackView];
        
        if (plies < 0) {
            //刷新 层数
            NSIndexPath *plicesIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [_tableView reloadRowsAtIndexPaths:@[plicesIndexPath] withRowAnimation:UITableViewRowAnimationNone];

            for (NSInteger x = -plies; x > 0; x --) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(cellCount-1) inSection:0];
                NSArray *insertIndexPath = [NSArray arrayWithObjects:indexPath, nil];
                
                [UIView animateWithDuration:0.5 animations:^{
                    [self.tableView beginUpdates];
                    cellCount--;
                    [self.tableView deleteRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationTop];
                    [self.tableView endUpdates];
                }];
                
            }
        } else if (plies > 0) {
            //刷新 层数
            NSIndexPath *plicesIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            [_tableView reloadRowsAtIndexPaths:@[plicesIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(lPlies+1) inSection:0];
            NSArray *insertIndexPath = [NSArray arrayWithObjects:indexPath, nil];
            
            for (NSInteger x = 0; x < plies; x ++) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self.tableView beginUpdates];
                    cellCount++;
                    [self.tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationBottom];
                    [self.tableView endUpdates];
                }];
                
            }
        } else {
            
        }
        [self.tableView reloadData];
    } else {
        switch (indexPath.row) {
            case 0:
                
                break;
                
            case 1:
                self.backView.alpha = 1;
                _backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                self.selectTable.alpha = 1;
                break;
                
            default:
            {
                if (lastClick == indexPath.row) {
                    lastClick = 100;
                    [_tableView reloadData];
                } else {
                    lastClick = indexPath.row;
                    [_tableView reloadData];
                }
            }
                break;
        }
    }
}

#pragma mark - custom
- (void)hiddenBackView{
    _backView.alpha = 0;
    _selectTable.alpha = 0;
}

- (IBAction)cancelSelect:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okSelect:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setUI



#pragma mark - lazy
- (UITableView *)selectTable{
    if (!_selectTable) {
        _selectTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith-200, 40*pliesCount)];
        _selectTable.tag = SelectTableTag;
        _selectTable.center = self.view.center;
        _selectTable.delegate = self;
        _selectTable.dataSource = self;
        [_selectTable registerNib:[UINib nibWithNibName:SelectCellIdentifier bundle:nil] forCellReuseIdentifier:SelectCellIdentifier];
        _selectTable.layer.masksToBounds = YES;
        _selectTable.layer.cornerRadius = 8;
        _selectTable.alpha = 0;
        [self.view addSubview:_selectTable];
    }
    return _selectTable;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBackView)];
        [_backView addGestureRecognizer:click];
        [self.view addSubview:_backView];
//        [_backView addSubview:self.selectTable];
    }
    return _backView;
}

- (NSMutableArray *)heights{
    if (!_heights) {
        _heights = [[NSMutableArray alloc] init];
    }
    return _heights;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = YCCellLineColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.yc_height = _tableView.yc_height-49;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:SizeCellIdentifier bundle:nil] forCellReuseIdentifier:SizeCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:PliesCellIdentifier bundle:nil] forCellReuseIdentifier:PliesCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:SpecsCellIdentifier bundle:nil] forCellReuseIdentifier:SpecsCellIdentifier];
//        [_tableView registerClass:NSClassFromString(SpecsCellIdentifier) forCellReuseIdentifier:SpecsCellIdentifier];
    }
    return _tableView;
}

@end
