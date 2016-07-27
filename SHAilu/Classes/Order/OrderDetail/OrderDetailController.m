//
//  OrderDetailController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/21.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailCell.h"
#import "OrderFooter.h"
#import "MJChiBaoZiHeader.h"

@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger stepCount;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *tableViewBackView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *stepOne;
@property (weak, nonatomic) IBOutlet UIImageView *stepOneTop;
@property (weak, nonatomic) IBOutlet UIImageView *nextIcon;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *stepTwo;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *stepThree;
@property (weak, nonatomic) IBOutlet UIImageView *lastIcon;

@property (weak, nonatomic) IBOutlet UIView *moveView;

@property (weak, nonatomic) IBOutlet UILabel *statuTitle;


@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    stepCount = 1;
    self.title = @"订单追踪";
    [self setTableView];
//    [self setStepIcon];
}

- (void)viewWillAppear:(BOOL)animated{
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

- (void)viewDidAppear:(BOOL)animated{
    [_stepOne stopAnimating];
    [_stepTwo stopAnimating];
    [_stepThree stopAnimating];
    [self performSelector:@selector(moveToStep:) withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
- (void)moveToStep:(NSInteger)index{
    
    switch (index) {
        case 1:
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"stepOne" ofType:@"gif"];
            NSData *gifData = [NSData dataWithContentsOfFile:path];
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
            _stepOne.animatedImage = image;
            _statuTitle.text = @"正在生产中……";
        }
            break;
        case 2:
        {
            _nextIcon.image = [UIImage imageNamed:@"order_step_next"];
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"stepTwo" ofType:@"gif"];
            NSData *gifData2 = [NSData dataWithContentsOfFile:path2];
            FLAnimatedImage *image2 = [FLAnimatedImage animatedImageWithGIFData:gifData2];
            _stepTwo.animatedImage = image2;
            _statuTitle.text = @"正在打包中……";
        }
            break;
        case 3:
        {
            _lastIcon.image = [UIImage imageNamed:@"order_step_next"];
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"stepThree" ofType:@"gif"];
            NSData *gifData3 = [NSData dataWithContentsOfFile:path3];
            FLAnimatedImage *image3 = [FLAnimatedImage animatedImageWithGIFData:gifData3];
            _stepThree.animatedImage = image3;
            _statuTitle.text = @"正在配送中……";
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - action
- (void)loadNewData{
    [NSThread sleepForTimeInterval:1.5f];
    [self.tableView.mj_header endRefreshing];
    [self moveToStep:stepCount/2];
    stepCount ++ ;
    [self.tableView beginUpdates];
    [self.dataSource insertObject:[NSString stringWithFormat:@"您的订单已有2000件完成并打包，已有2000件制作完成，准备打包，还剩余1000件正在制作(%ld)",(long)stepCount] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *insertIndexPath = [NSArray arrayWithObjects:indexPath, nil];
    [self.tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
    CGSize size = [[self.dataSource yc_objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake(ScreenWith-(45+8)-(8+8)-40, 999)
                                                                                 options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                                              attributes:attribute context:nil].size;
//    NSLog(@"[self.dataSource yc_objectAtIndex:indexPath.row]:%@  size.height:%f",[self.dataSource yc_objectAtIndex:indexPath.row],size.height);
    return  size.height+(8+8)+2;
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
        
        if (indexPath.row == 0) {
            cell.orderText.textColor = YCNavTitleColor;
            cell.topLine.backgroundColor = YCNavTitleColor;
            cell.centerLine.backgroundColor = YCNavTitleColor;
            cell.topLine.backgroundColor = YCNavTitleColor;
            
        } else {
            cell.orderText.textColor = [UIColor blackColor];
            cell.topLine.backgroundColor = [UIColor lightGrayColor];
            cell.centerLine.backgroundColor = [UIColor lightGrayColor];;
            cell.topLine.backgroundColor = [UIColor lightGrayColor];;
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

#pragma mark - setUI
- (void)setTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.rowHeight = UITableViewAutomaticDimension;
    //    _tableView.estimatedRowHeight = 30;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:@"OrderDetailCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderFooter" bundle:nil] forCellReuseIdentifier:@"OrderFooter"];
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableViewBackView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, _tableView.yc_width-2, 1)];
//    _tableViewBackView.image = [UIImage imageNamed:@"orderText"];
            _tableViewBackView.backgroundColor = [UIColor whiteColor];
    [_tableView addSubview:_tableViewBackView];
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

- (void)setStepIcon{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"stepOne" ofType:@"gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
//    _stepOne.animatedImage = image;
    
    _stepOne.image = [UIImage imageNamed:@"order_step1_top"];
    
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"stepTwo" ofType:@"gif"];
    NSData *gifData2 = [NSData dataWithContentsOfFile:path2];
    FLAnimatedImage *image2 = [FLAnimatedImage animatedImageWithGIFData:gifData2];
    _stepTwo.animatedImage = image2;
    
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"stepThree" ofType:@"gif"];
    NSData *gifData3 = [NSData dataWithContentsOfFile:path3];
    FLAnimatedImage *image3 = [FLAnimatedImage animatedImageWithGIFData:gifData3];
    _stepThree.animatedImage = image3;
    

}

#pragma mark - lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
