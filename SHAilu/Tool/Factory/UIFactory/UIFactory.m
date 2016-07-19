//
//  UIFactory.m
//  IBZApp
//
//  Created by 尹成 on 16/7/8.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "UIFactory.h"
#import "HomeViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"

@implementation UIFactory

- (UISegmentedControl *)getSegmentedControlWithTarget:(id)target Items:(NSArray *)items action:(SEL)action{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.bounds = CGRectMake(0, 8, 160, 27);
#ifdef ThemeColor
    NSLog(@"定义了主题色<ThemeColor>");
    segmentControl.tintColor = [UIColor whiteColor];
    //  下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
#else
    NSLog(@"没有定义主题色<ThemeColor>");
    segmentControl.tintColor = YCLightGrayColor;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
#endif
    
    [segmentControl addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    
    return segmentControl;
}

- (UIBarButtonItem *)getBackBarButtonItemWithTarget:(id)target action:(SEL)action{
#ifdef ThemeColor
    UIImage *image = [UIImage imageNamed:@"nav_back_white"];
#else
    UIImage *image = [UIImage imageNamed:@"nav_back_white"];
#endif
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:action];
    return item;
}

- (UIBarButtonItem *)getSearchBarButtonItemWithTarget:(id)target action:(SEL)action{
    
#ifdef ThemeColor
    UIImage *image = [UIImage imageNamed:@"nav_search_white"];
#else
    UIImage *image = [UIImage imageNamed:@"nav_search_gray"];
#endif
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:action];
    return item;
}

- (UIView *)getCustomMenuWithAttributes:(NSArray *)attributes{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, ScreenWith, 54 * ScreenScale);
    
    CGRect itemFram = CGRectMake(0, 0, view.yc_width/attributes.count, view.yc_height);
    NSUInteger index;
    for (NSDictionary *dict in attributes) {
        index = [attributes indexOfObject:dict];
//        NSString * const CustomMenuItemName;
//        NSString * const CustomMenuItemNoarmalColor;
//        NSString * const CustomMenuItemNoarmalImage;
//        NSString * const CustomMenuItemSelectedColor;
//        NSString * const CustomMenuItemSelectedImageUp;
//        NSString * const CustomMenuItemSelectedImageDown;
        
        
        
        
    }
    
    return view;
}

- (UITableView *)getTableViewWithFrame:(CGRect)frame Target:(id)target cells:(NSArray *)cells refreshBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock loadBlock:(MJRefreshComponentRefreshingBlock)loadBlock{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.dataSource = target;
    tableView.delegate = target;
    tableView.estimatedRowHeight = 110;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.scrollsToTop = YES;
    
    for (NSString *cellName in cells) {
        [tableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
    }
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:loadBlock];
    [footer setTitle:@" " forState:MJRefreshStateIdle];
    [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
    tableView.mj_footer = footer;
    return tableView;
}

- (UITableView *)getTableViewWithTarget:(id)target
                                  cells:(NSArray *)cells
                           refreshBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
                              loadBlock:(MJRefreshComponentRefreshingBlock)loadBlock{
    
    return [self getTableViewWithFrame:CGRectZero
                                Target:target
                                 cells:cells
                          refreshBlock:refreshingBlock
                             loadBlock:loadBlock];
}

- (UILabel *)getLineWithFrame:(CGRect)fram Direction:(Direction)direction{
    return [self getLableWithFrame:fram Direction:direction];
}

- (UILabel *)getLableWithFrame:(CGRect)fram Direction:(Direction)direction{
    UILabel *lable = [[UILabel alloc] initWithFrame:fram];
    lable.backgroundColor = YCCellLineColor;
    switch (direction) {
        case DirectionVertical:
            //垂直
            lable.yc_width = 1;
            break;
        case DirectionHorizontal:
            lable.yc_height = 1;
            break;
        default:
            break;
    }
    return lable;
}

#define TabBarSelectedColor [UIColor whiteColor]

- (YCTabBarController *)getTabBarController{
    YCTabBarController *tabbarController = [[YCTabBarController alloc] init];
    
    UIViewController *homeVC        = [[HomeViewController alloc] init];
    homeVC.tabBarItem.title         = @"首页";
    [homeVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBarSelectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [homeVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBarSelectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    homeVC.tabBarItem.image         = [[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *storeNV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [tabbarController addChildViewController:storeNV];
    
    UIViewController *orderVC        = [[OrderViewController alloc] init];
    orderVC.tabBarItem.title         = @"订单";
    [orderVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBarSelectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [orderVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBarSelectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    orderVC.tabBarItem.image         = [[UIImage imageNamed:@"tabbar_classify"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *orderNV = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [tabbarController addChildViewController:orderNV];

    UIViewController *myVC        = [[MyViewController alloc] init];
    myVC.tabBarItem.title         = @"我的";
    [myVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBarSelectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [myVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TabBarSelectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    myVC.tabBarItem.image         = [[UIImage imageNamed:@"tabbar_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *myNV = [[UINavigationController alloc] initWithRootViewController:myVC];
    [tabbarController addChildViewController:myNV];
    
    return tabbarController;
}

















- (void)dismissAction{
    
}

@end
