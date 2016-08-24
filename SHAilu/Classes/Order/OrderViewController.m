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
#import "UIScrollView+EmptyDataSet.h"

#define MAX_LIMIT_NUMS     200
NSString *placeHolder = @"如有其它需求,请备注";

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{
    NSInteger pageIndex;
}

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic ,strong) NSMutableArray *showedIndexPaths;
//@property (nonatomic, strong) UIImageView    *busyView;
@property (nonatomic, weak) IBOutlet UIView *buyView;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property (nonatomic, weak) IBOutlet UITextField *buyCount;
@property (weak, nonatomic) IBOutlet UIButton *buyViewOKBt;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberLb.text = [NSString stringWithFormat:@"%ld/%ld",(long)MAX_LIMIT_NUMS,(long)MAX_LIMIT_NUMS];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = false;

//    [self.dataSource addObjectsFromArray:@[@"",@"",@"",@""]];
    self.title = @"订单";
    
    [[NSBundle mainBundle] loadNibNamed:@"BuyView" owner:self options:nil];
    _buyView.frame = self.view.bounds;
    [self.view addSubview:_buyView];
    _remark.layer.masksToBounds = YES;
    _remark.layer.cornerRadius = 4;
    _remark.layer.borderColor = YCCellLineColor.CGColor;
    _remark.layer.borderWidth = 1;
    _remark.text = placeHolder;
    _remark.textColor = [UIColor lightGrayColor];
    _remark.delegate = self;

    _buyView.alpha = 0;
    
    pageIndex = 1;
    [self loadData];
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
    _remark.text = placeHolder;
    _remark.textColor = [UIColor grayColor];
    _buyView.alpha = 1;
    _buyView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [_buyCount becomeFirstResponder];
    _buyViewOKBt.tag = sender.tag;
}

- (IBAction)orderDetailAction:(UIButton *)sender {
    
    if (sender.tag < 3000 || sender.tag +1 > 4000) {
        return;
    }
    
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
        NSString *remarkStr = @"";
        if (![_remark.text isEqualToString:placeHolder]) {
            remarkStr = _remark.text;
        }
        [[BaseAPI sharedAPI].orderService orderOnlineAgainWithOrderID:order.Uid
                                                                count:_buyCount.text
                                                               remark:remarkStr
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

- (IBAction)confirmPriceAction:(UIButton *)sender{
    
    if (sender.tag < 4000) {
        return;
    }
    
    NSInteger index = sender.tag - 4000;
    
    if (index < 0) {
        NSLog(@"---------error-----------");
        return;
    }
    
    OrderModel *order = [_dataSource yc_objectAtIndex:index];

    [[BaseAPI sharedAPI].orderService confirmOrderInfoWithOrderID:order.Uid
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              if (1 == [[responseObject yc_objectForKey:@"Success"] integerValue]) {
                                                                  [MBProgressHUD showMessageAuto:@"确认报价成功"];
#warning 刷新状态逻辑不合理
                                                                  pageIndex -- ;
                                                                  [self loadData];
                                                              } else {
                                                                  [MBProgressHUD showMessageAuto:[responseObject yc_objectForKey:@"ErrorMsg"]];
                                                              }
                                                              
                                                          } failure:nil];
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
    OrderModel *order = [_dataSource yc_objectAtIndex:indexPath.row];
    
    [cell configWithData:order];
    
    if (1 == [order.Status integerValue]) {
        cell.orderButton.tag = indexPath.row + 4000;
        [cell.orderButton addTarget:self action:@selector(confirmPriceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (0 == [order.Status integerValue]) {
        cell.orderButton.tag = indexPath.row + 2000;
    }
    else {
        cell.orderButton.tag = indexPath.row + 3000;
        [cell.orderButton addTarget:self action:@selector(orderDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
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

#pragma textView
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:placeHolder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = placeHolder;
        textView.textColor = [UIColor grayColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.numberLb.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数 口口日
    self.numberLb.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}


#pragma DZNEmptyDataSet
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *stirng = @"暂无数据,快去下单吧";
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    //    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:stirng attributes:attributes];
}

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    NSString *stirng = @"刷新一下";
//    UIFont *font = [UIFont systemFontOfSize:14];
//    UIColor *textColor = [UIColor grayColor];
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//    [attributes setObject:font forKey:NSFontAttributeName];
//    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//    return [[NSAttributedString alloc] initWithString:stirng attributes:attributes];
//}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [UIImage imageNamed:@"orderEmp"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [self refresh];
}



#pragma mark - UI
- (void)setTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
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
