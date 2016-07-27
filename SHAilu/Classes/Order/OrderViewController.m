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
#import "MJChiBaoZiHeader.h"
#import "MJDiyFooter.h"

//NSString *CellIdentifier = @"OrderCell";

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic ,strong) NSMutableArray *showedIndexPaths;
@property (nonatomic, strong) UIImageView    *busyView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = false;

    [self.dataSource addObjectsFromArray:@[@"",@"",@""]];
    self.title = @"订单";
    
    _busyView= [[UIImageView alloc] init];
    _busyView.bounds = CGRectMake(0, 0, 100, 100);
    _busyView.center = [[UIApplication sharedApplication].delegate window].center;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i=0; i<57; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"load%d",i]];
        [imageArray addObject:image];
    }
    
    _busyView.animationImages = imageArray;
    _busyView.animationDuration = 57*0.05;
    _busyView.animationRepeatCount = 100;
    [self.view addSubview:_busyView];
}

- (void)viewWillAppear:(BOOL)animated{
    YCTabBarController *tabBarController = (YCTabBarController*)self.tabBarController;
    tabBarController.customView.hidden = NO;
    [_busyView startAnimating];
}

- (void)viewDidAppear:(BOOL)animated{

    
    
    
    //得到图片的路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
//    //将图片转为NSData
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
//    _busyView.animatedImage = image;
//    [[[UIApplication sharedApplication].delegate window] addSubview:_busyView];
//    [_busyView startAnimating];
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
- (void)loadNewData{
    [NSThread sleepForTimeInterval:1.5f];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData{
    [NSThread sleepForTimeInterval:1.5f];
    [self.tableView.mj_footer endRefreshing];
}

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
    else {
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
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_footer = [MJDiyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
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
