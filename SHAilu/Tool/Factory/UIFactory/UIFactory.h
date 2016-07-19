//
//  UIFactory.h
//  IBZApp
//
//  Created by 尹成 on 16/7/8.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
#import <UIKit/UIKit.h>
#import "YCTabBarController.h"

/**
 *  方向
 */
typedef NS_ENUM(NSInteger, Direction) {
    /**
     *  垂直
     */
    DirectionVertical,
    /**
     *  水平
     */
    DirectionHorizontal
};

@interface UIFactory : NSObject

//------------------------UISegmentedControl-------------------------//
- (UISegmentedControl *)getSegmentedControlWithTarget:(id)target Items:(NSArray *)items action:(SEL)action;


//------------------------UIBarButtonItem-------------------------//
- (UIBarButtonItem *)getBackBarButtonItemWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)getSearchBarButtonItemWithTarget:(id)target action:(SEL)action;


//------------------------CustomMenu-------------------------//
- (UIView *)getCustomMenuWithAttributes:(NSDictionary *)attributes;

//------------------------UITableView-------------------------//
- (UITableView *)getTableViewWithTarget:(id)target
                                  cells:(NSArray *)cells
                           refreshBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
                              loadBlock:(MJRefreshComponentRefreshingBlock)loadBlock;

- (UITableView *)getTableViewWithFrame:(CGRect)frame
                                Target:(id)target
                                  cells:(NSArray *)cells
                           refreshBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
                              loadBlock:(MJRefreshComponentRefreshingBlock)loadBlock;

//------------------------UILable-------------------------//
- (UILabel *)getLableWithFrame:(CGRect)fram Direction:(Direction)direction;
- (UILabel *)getLineWithFrame:(CGRect)fram Direction:(Direction)direction;

//------------------------ScrolPageView-------------------------//


//------------------------TabBarController-------------------------//
- (YCTabBarController *)getTabBarController;

@end
