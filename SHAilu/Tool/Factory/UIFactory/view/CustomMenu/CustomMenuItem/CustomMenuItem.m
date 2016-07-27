//
//  CustomMenuItem.m
//  IBZApp
//
//  Created by 尹成 on 16/7/11.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import "CustomMenuItem.h"
#import "CustomMenuMoreItem.h"
#import "CustomMenuOrderItem.h"
#import "CustomMenu.h"

//NSString * const CustomMenuItemType;//CustomMenuMoreItem
//NSString * const CustomMenuItemName;
//NSString * const CustomMenuItemNoarmalColor;
//NSString * const CustomMenuItemNoarmalImage;
//NSString * const CustomMenuItemSelectedColor;
//NSString * const CustomMenuItemSelectedImageUp;
//NSString * const CustomMenuItemSelectedImageDown;

@implementation CustomMenuItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont yc_systemFontOfSize:13];
    }
    return self;
}

+ (instancetype)initWithFrame:(CGRect)frame Attributes:(NSDictionary *)attributes{

    if ([[attributes yc_objectForKey:@"CustomMenuItemType"] isEqualToString:@"CustomMenuMoreItem"]) {
        
        CustomMenuMoreItem *moreItem = [[CustomMenuMoreItem alloc] initWithFrame:frame];
        
        moreItem.customMenuType = CustomMenuTypeMore;
        [moreItem setTitle:[attributes yc_objectForKey:@"CustomMenuItemName"]               forState:UIControlStateNormal];
        [moreItem setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [moreItem setTitleColor:[attributes yc_objectForKey:@"CustomMenuItemNoarmalColor"]  forState:UIControlStateNormal];
        [moreItem setImage:[UIImage imageNamed:[attributes yc_objectForKey:@"CustomMenuItemNoarmalImage"]] forState:UIControlStateNormal];
//        [moreItem setTitleColor:[attributes yc_objectForKey:@"CustomMenuItemSelectedColor"] forState:UIControlStateSelected];
        [moreItem setImage:[UIImage imageNamed:[attributes yc_objectForKey:@"CustomMenuItemSelectedImageDown"]] forState:UIControlStateSelected];
        
        moreItem.tag = 20001;
        NSLog(@"moreItem.tag:%ld",(long)moreItem.tag);
        return moreItem;
    } else {
        CustomMenuOrderItem *orderItem = [[CustomMenuOrderItem alloc] initWithFrame:frame];
        
        orderItem.name = [attributes yc_objectForKey:@"CustomMenuItemName"];
        orderItem.NoarmalColor = [attributes yc_objectForKey:@"CustomMenuItemNoarmalColor"];
        orderItem.NoarmalImage = [attributes yc_objectForKey:@"CustomMenuItemNoarmalImage"];
        orderItem.SelectedColor = [attributes yc_objectForKey:@"CustomMenuItemSelectedColor"];
        orderItem.SelectedImageDown = [attributes yc_objectForKey:@"CustomMenuItemSelectedImageDown"];
        orderItem.SelectedImageUp = [attributes yc_objectForKey:@"CustomMenuItemSelectedImageUp"];
        
        orderItem.customMenuType = CustomMenuTypeOrder;
        [orderItem setTitle:[attributes yc_objectForKey:@"CustomMenuItemName"]               forState:UIControlStateNormal];
        [orderItem setTitleColor:[attributes yc_objectForKey:@"CustomMenuItemNoarmalColor"]  forState:UIControlStateNormal];
        [orderItem setImage:[UIImage imageNamed:[attributes yc_objectForKey:@"CustomMenuItemNoarmalImage"]] forState:UIControlStateNormal];
        [orderItem setTitleColor:[attributes yc_objectForKey:@"CustomMenuItemSelectedColor"] forState:UIControlStateSelected];
        [orderItem setImage:[UIImage imageNamed:[attributes yc_objectForKey:@"CustomMenuItemSelectedImageDown"]] forState:UIControlStateSelected];
        orderItem.tag = 10001;
        NSLog(@"orderItem.tag:%ld",(long)orderItem.tag);
        return orderItem;
    }
}

- (void)setCustomTouchUpInsideBlock:(CustomTouchUpInsideBlock)customTouchUpInsideBlock{
    _customTouchUpInsideBlock = customTouchUpInsideBlock;
}

- (void)changeCustomStatu{
    
}

@end
