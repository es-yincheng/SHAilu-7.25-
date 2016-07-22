//
//  OrderDetail.m
//  SHAilu
//
//  Created by 尹成 on 16/7/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderDetail.h"
#import "OrderDetailCell.h"
#import "OrderFooter.h"
#import "MJChiBaoZiHeader.h"

//NSString *CellIdentifier = @"OrderDetailCell";

@interface OrderDetail ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *tableViewBackView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation OrderDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];

    
}

- (void)viewDidAppear:(BOOL)animated{
//    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    spring.toValue = @(245);
//    spring.beginTime = CACurrentMediaTime();
//    spring.springBounciness = 0.0f;
//    [self.tableView pop_addAnimation:spring forKey:@"position"];\
    
    NSArray *array = @[@"您的订单已有2000件完成并打包，已有2000件制作完成，准备打包，还剩余1000件正在制作",@"您的订单已完成3000件，剩余4000件正在制作",@"您的订单已2000件正在制作",@"您的订单已报价成功，正在安排定制",@"您提交了订单，正在等待报检"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *insertIndexPath = [NSArray arrayWithObjects:indexPath, nil];
    NSInteger x = 0;
    for (NSString *string in array) {
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.tableView beginUpdates];
            [self.dataSource insertObject:string atIndex:0];
            [self.tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationBottom];
            [self.tableView endUpdates];
        }];
        x ++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - action
- (void)loadNewData{
    [NSThread sleepForTimeInterval:1.5f];
    [self.tableView.mj_header endRefreshing];
    

    [self.tableView beginUpdates];
    [self.dataSource insertObject:@"您的订单已有2000件完成并打包，已有2000件制作完成，准备打包，还剩余1000件正在制作" atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *insertIndexPath = [NSArray arrayWithObjects:indexPath, nil];
    [self.tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}


#pragma mark - delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.dataSource.count) {
        OrderDetailCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell"];
        cell.orderText.text = [self.dataSource yc_objectAtIndex:indexPath.row];
        if (indexPath.row == self.dataSource.count - 1) {
            cell.buttonLine.hidden = YES;
        } else {
            cell.buttonLine.hidden = NO;
        }
        return cell;
    } else {
        OrderFooter *cell = [_tableView dequeueReusableCellWithIdentifier:@"OrderFooter"];
        NSLog(@"height:%f",cell.yc_height);
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > -54) {
        return;
    }
    _tableViewBackView.yc_y = scrollView.contentOffset.y;
    _tableViewBackView.yc_height = - scrollView.contentOffset.y - 54;
//    NSLog(@"tableHeader.Height:%f",self.tableView.mj_header.yc_height);
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
        
        UIImageView *tableViewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, ScreenWith, 45)];
        tableViewHeader.image = [UIImage imageNamed:@"orderHeader"];
        [self.view addSubview:tableViewHeader];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(21, CGRectGetMaxY(tableViewHeader.frame), ScreenWith - 42, ScreenHeight - CGRectGetMaxY(tableViewHeader.frame) - 49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 30;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderFooter" bundle:nil] forCellReuseIdentifier:@"OrderFooter"];
        [self.view addSubview:_tableView];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _tableViewBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _tableView.yc_width, 1)];
        _tableViewBackView.image = [UIImage imageNamed:@"orderText"];
//        _tableViewBackView.backgroundColor = [UIColor clearColor];
        [_tableView addSubview:_tableViewBackView];
        
        
     //   MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        // Set the ordinary state of animated images
     //   [header setImages:idleImages forState:MJRefreshStateIdle];
        // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
     //   [header setImages:pullingImages forState:MJRefreshStatePulling];
        // Set the refreshing state of animated images
     //   [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        // Set header
     //   self.tableView.mj_header = header;
        
        
        self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        // 马上进入刷新状态
//        [self.tableView.mj_header beginRefreshing];
        
    }
    return _tableView;
}

@end
