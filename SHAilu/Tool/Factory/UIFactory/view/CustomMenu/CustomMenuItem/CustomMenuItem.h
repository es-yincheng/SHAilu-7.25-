//
//  CustomMenuItem.h
//  IBZApp
//
//  Created by 尹成 on 16/7/11.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

typedef void(^CustomTouchUpInsideBlock)();

typedef NS_ENUM(NSInteger, CustomStatu){
    CustomStatuNoarmal,
    CustomStatuSelectedUp,
    CustomStatuSelectedDown
};

typedef NS_ENUM(NSInteger, CustomMenuType){
    CustomMenuTypeOrder,
    CustomMenuTypeMore
};

#import <UIKit/UIKit.h>

@interface CustomMenuItem : UIButton

//NSString * const CustomMenuItemType;//CustomMenuMoreItem
//NSString * const CustomMenuItemName;
//NSString * const CustomMenuItemNoarmalColor;
//NSString * const CustomMenuItemNoarmalImage;
//NSString * const CustomMenuItemSelectedColor;
//NSString * const CustomMenuItemSelectedImageUp;
//NSString * const CustomMenuItemSelectedImageDown;

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, strong) UIColor  *NoarmalColor;
@property (nonatomic, copy  ) NSString *NoarmalImage;
@property (nonatomic, strong) UIColor  *SelectedColor;
@property (nonatomic, copy  ) NSString *SelectedImageUp;
@property (nonatomic, copy  ) NSString *SelectedImageDown;
@property (nonatomic, assign) CustomStatu customStatu;
@property (nonatomic, assign) CustomMenuType customMenuType;
@property (nonatomic, copy)   CustomTouchUpInsideBlock customTouchUpInsideBlock;

+ (instancetype)initWithFrame:(CGRect)frame Attributes:(NSDictionary *)attributes;
//- (instancetype)initWithFrame:(CGRect)frame Attributes:(NSDictionary *)attributes;
- (void)changeCustomStatu;

@end
