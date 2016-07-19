//
//  CustomMenu.h
//  IBZApp
//
//  Created by 尹成 on 16/7/11.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomMenuItem.h"
#import "CustomMenuOrderItem.h"
#import "CustomMenuMoreItem.h"

typedef void(^SelectItemBlock)(NSInteger itemIndex, CustomStatu customStatu);

@interface CustomMenu : UIView

@property (nonatomic, strong) CustomMenuItem *moreItem;
@property (nonatomic, strong) UILabel        *selecLine;
@property (nonatomic, copy  ) SelectItemBlock selectItemBlock;

- (instancetype)initWithFrame:(CGRect)frame
                   Attributes:(NSArray *)attributes
              selectItemBlock:(SelectItemBlock)selectItemBlock;

@end
