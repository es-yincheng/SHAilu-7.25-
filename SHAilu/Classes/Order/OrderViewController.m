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
#import "UIImage+GIF.h"
#import "OrderStatusController.h"
#import "OrderDetailController.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageIndex;
}

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic ,strong) NSMutableArray *showedIndexPaths;
//@property (nonatomic, strong) UIImageView    *busyView;
@property (nonatomic, weak) IBOutlet UIView *buyView;
@property (nonatomic, weak) IBOutlet UITextField *buyCount;
@property (weak, nonatomic) IBOutlet UIButton *buyViewOKBt;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = false;

//    [self.dataSource addObjectsFromArray:@[@"",@"",@"",@""]];
    self.title = @"订单";
    
    [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:self options:nil];
    _buyView.frame = self.view.bounds;
    [self.view addSubview:_buyView];
    _buyView.alpha = 0;
    
    pageIndex = 1;
    [self loadData];
#warning 无数据时的提醒界面
}

- (void)viewWillAppear:(BOOL)animated{
    YCTabBarController *tabBarController = (YCTabBarController*)self.tabBarController;
    tabBarController.customView.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
//    [self performSelector:@selector(loadData) withObject:nil afterDelay:2.0f];
//    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - custom
- (void)refresh{
    pageIndex = 1;
    [self loadData];
}

- (void)loadData{
    [[BaseAPI sharedAPI].orderService getOrdersWithPageIndex:pageIndex
                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                         
                                                         [self.tableView.mj_header endRefreshing];
                                                         [self.tableView.mj_footer endRefreshing];
                                                         
                                                         NSMutableArray *orders = [OrderModel yc_objectWithKeyValues:responseObject];
                                                         if (orders.count > 0) {
                                                             if (pageIndex == 1) {
                                                                 self.dataSource = orders;
                                                             } else {
                                                                 [self.dataSource addObjectsFromArray:orders];
                                                             }
                                                             pageIndex ++;
                                                             [self.tableView reloadData];
                                                         }
                                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                         [self.tableView.mj_header endRefreshing];
                                                         [self.tableView.mj_footer endRefreshing];
                                                         [MBProgressHUD showMessageAuto:@"网络连接失败,请稍后重试"];
                                                     }];
}

- (IBAction)buyAction:(UIButton *)sender{
    [self.view bringSubviewToFront:_buyView];
    _buyView.alpha = 1;
    _buyView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [_buyCount becomeFirstResponder];
    _buyViewOKBt.tag = sender.tag;
}

- (IBAction)orderDetailAction:(UIButton *)sender {
    
    NSInteger index = sender.tag - 3000;
    
    if (index < 0) {
        NSLog(@"---------error-----------");
        return;
    }
    OrderModel *order = [_dataSource yc_objectAtIndex:index];
    
    OrderStatusController *vc = [[OrderStatusController alloc] init];
    vc.orderID = order.Uid;
    [self.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.tabBarController;
    tabBarController.customView.hidden = YES;
}

- (IBAction)buyOkAction:(UIButton *)sender{
    if (_buyCount.text.length > 0) {
        
        NSInteger index = sender.tag - 3000;
        
        if (index < 0) {
            NSLog(@"---------error-----------");
            return;
        }
        
        OrderModel *order = [_dataSource yc_objectAtIndex:index];
        
        [[BaseAPI sharedAPI].orderService orderOnlineAgainWithOrderID:order.Uid
                                                                count:_buyCount.text
                                                               remark:@"buy again"
                                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                  NSLog(@"再次购买:%@",responseObject);
                                                                  if (1 == [[responseObject yc_objectForKey:@"Success"] integerValue]) {
                                                                      _buyView.alpha = 0;
                                                                      [MBProgressHUD showMessageAuto:@"再次购买成功"];
                                                                      _buyCount.text = nil;
                                                                  } else {
                                                                      [MBProgressHUD showMessageAuto:[responseObject yc_objectForKey:@"ErrorMsg"]];
                                                                  }
                                                              } failure:nil];
    } else {
        [MBProgressHUD showMessageAuto:@"请输入购买数量"];
    }
}

- (IBAction)disMissBuyView:(id)sender{
    _buyView.alpha = 0;
    _buyCount.text = nil;
}

#pragma mark - action
//- (void)loadNewData{
//    [NSThread sleepForTimeInterval:1.5f];
//    [self.tableView.mj_header endRefreshing];
//}

//- (void)loadMoreData{
//    [self loadData];
//}

#pragma mark - delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderModel *order = [_dataSource yc_objectAtIndex:indexPath.row];
    
    if ([order.Status integerValue] == 0) {
        return 210;
    } else {
        return 210 - 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    
    [cell configWithData:[_dataSource yc_objectAtIndex:indexPath.row]];
    
    cell.orderButton.tag = indexPath.row + 3000;
    [cell.orderButton addTarget:self action:@selector(orderDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.buyButton.tag = indexPath.row + 3000;
    [cell.buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell configWithData:@{@"status":[NSString stringWithFormat:@"%ld",(long)indexPath.row]}];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailController *vc = [[OrderDetailController alloc] init];
    OrderModel *order = [_dataSource yc_objectAtIndex:indexPath.row];
    vc.orderID = order.Uid;
    [self.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.tabBarController;
    tabBarController.customView.hidden = YES;
    
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    //indexpath第一次加载的有动画  否则没有
//    if ([self.showedIndexPaths containsObject:indexPath]) {
//        return;
//    }
//    else {
//        [self.showedIndexPaths addObject:indexPath];
//    }
//    //!!!: 次页面中 cell加载时 自定义了动画
//    CATransform3D rotation;
//    rotation = CATransform3DMakeTranslation(0, 15, 0);
//    rotation.m34 = 1.0/ -600;
//    
//    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
//    cell.alpha = 0;
//    cell.layer.transform = rotation;
//    cell.layer.anchorPoint = CGPointMake(0, 0.5);
//    
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:0.5];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.alpha = 1;
//    [UIView commitAnimations];
//}

#pragma mark - UI
- (void)setTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = YCCellLineColor;
//    _tableView.estimatedRowHeight = 250;
//    _tableView.rowHeight = UITableViewRowAnimationRight;
//    _tableView.rowHeight = 210;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
//    _tableView.mj_footer = [MJDiyFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
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
