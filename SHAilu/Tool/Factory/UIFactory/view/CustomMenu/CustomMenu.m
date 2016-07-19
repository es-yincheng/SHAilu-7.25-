//
//  CustomMenu.m
//  IBZApp
//
//  Created by 尹成 on 16/7/11.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "CustomMenu.h"
//#import "CustomMenuItem.h"

NSUInteger MenuItemTag = 2100;

@implementation CustomMenu

- (instancetype)initWithFrame:(CGRect)frame
                   Attributes:(NSArray *)attributes
              selectItemBlock:(SelectItemBlock)selectItemBlock{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.selectItemBlock = selectItemBlock;
        CGRect itemFram = CGRectMake(0, 0, self.yc_width/attributes.count, self.yc_height);
        NSUInteger index;
        UILabel *line = [[Factory sharedUI] getLableWithFrame:CGRectMake(0, self.yc_height - 1, self.yc_width, 1) Direction:DirectionHorizontal];
        [self addSubview:line];
        self.selecLine = [[Factory sharedUI] getLableWithFrame:CGRectMake(10, line.yc_y, self.yc_width/attributes.count - 20, 1) Direction:DirectionHorizontal];
        self.selecLine.backgroundColor = YCItemColor;
        [self addSubview:self.selecLine];
        for (NSDictionary *dict in attributes) {
            index = [attributes indexOfObject:dict];
            
            CustomMenuItem *menuItem = [CustomMenuItem initWithFrame:itemFram Attributes:dict];
            
            if (menuItem.customMenuType == CustomMenuTypeMore) {
                self.moreItem = menuItem;
            }
            
            menuItem.yc_x = index * menuItem.yc_width;
            NSLog(@"menuItem.frame:%f,%f,%f,%f",menuItem.frame.origin.x,menuItem.frame.origin.y,menuItem.frame.size.width,menuItem.frame.size.height);
            [menuItem addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
            menuItem.tag = MenuItemTag + index;
            [self addSubview:menuItem];
            
            if (index > 0) {
                UILabel *line = [[Factory sharedUI] getLableWithFrame:CGRectMake(menuItem.yc_x, 0, 1, self.yc_height) Direction:DirectionVertical];
                [self addSubview:line];
            }
        }
    }
    return self;
}

CustomMenuItem *currentButton;
- (IBAction)changeStatus:(CustomMenuItem *)sender{
    
    switch (sender.customMenuType) {
        case CustomMenuTypeMore:
        {
            sender.customTouchUpInsideBlock();
        }
            break;
            
        case CustomMenuTypeOrder:
        {
            if (currentButton != sender) {
                currentButton.selected = NO;
                currentButton.customStatu = CustomStatuNoarmal;
                currentButton = sender;
                currentButton.selected = YES;
                currentButton.customStatu = CustomStatuSelectedDown;
            } else {
                [currentButton changeCustomStatu];
            }
            self.selectItemBlock(currentButton.tag - MenuItemTag, currentButton.customStatu);
        }
            break;
            
        default:
            break;
    }
}

@end
