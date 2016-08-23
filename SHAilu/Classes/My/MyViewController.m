//
//  MyViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *companyName;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    CGRect frame = self.tableView.tableHeaderView.frame;
    frame.size.height = 1;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    headerView.backgroundColor = YCItemColor;
    [self.tableView setTableHeaderView:headerView];
    
    self.tableView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[BaseAPI sharedAPI].userService queryUserInfoWithUid:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                     
                                                     [UserModel yc_objectWithKeyValues:responseObject];
                                                     
                                                     if (1 == [[responseObject yc_objectForKey:@"Success"] integerValue]) {
                                                         UserModel *user = [UserModel yc_objectWithKeyValues:responseObject];
                                                         [user saveUserInfo];
                                                         _userName.text = user.Name;
                                                         _companyName.text = user.CompanyName;
                                                     }
                                                 } failure:nil];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
