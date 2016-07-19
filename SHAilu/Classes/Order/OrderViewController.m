//
//  OrderViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderDetail.h"

//NSString *CellIdentifier = @"OrderCell";

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic ,strong) NSMutableArray *showedIndexPaths;
@property (nonatomic, strong) FLAnimatedImageView *busyView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = false;

    [self.dataSource addObjectsFromArray:@[@"",@"",@""]];
    self.title = @"订单";
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated{
    _busyView= [[FLAnimatedImageView alloc] init];
    _busyView.bounds = CGRectMake(0, 0, 55, 55);
    _busyView.center = [[UIApplication sharedApplication].delegate window].center;
    //得到图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    _busyView.animatedImage = image;
    [[[UIApplication sharedApplication].delegate window] addSubview:_busyView];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - custom
- (void)loadData{
    [_busyView stopAnimating];
    [_busyView removeFromSuperview];
    [self.tableView reloadData];
}


#pragma mark - action


#pragma mark - delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //indexpath第一次加载的有动画  否则没有
    if ([self.showedIndexPaths containsObject:indexPath]) {
        return;
    }
    else
    {
        [self.showedIndexPaths addObject:indexPath];
    }
    //!!!: 次页面中 cell加载时 自定义了动画
    CATransform3D rotation;
    rotation = CATransform3DMakeTranslation(0, 15, 0);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    [UIView commitAnimations];
}

#pragma mark - UI
- (void)setTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.estimatedRowHeight = 250;
//    _tableView.rowHeight = UITableViewRowAnimationRight;
    _tableView.rowHeight = 210;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
}

#pragma mark - lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self setTableView];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)showedIndexPaths{
    if (!_showedIndexPaths) {
        _showedIndexPaths = [[NSMutableArray alloc] init];
    }
    return _showedIndexPaths;
}

@end
