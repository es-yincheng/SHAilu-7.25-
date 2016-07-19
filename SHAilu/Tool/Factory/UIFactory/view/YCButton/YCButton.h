//
//  YCButton.h
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

typedef void(^TouchBeginBlock)();
typedef void(^TouchEndedBlock)();

typedef NS_ENUM(NSInteger, YCButtonType) {
    YCButtonTypeDefault,
    YCButtonTypeAskData,
    YCButtonTypeOther
};

#import <UIKit/UIKit.h>

@interface YCButton : UIControl

@property (nonatomic, assign) YCButtonType    buttonType;
@property (nonatomic, copy  ) TouchBeginBlock touchBeginBlock;
@property (nonatomic, copy  ) TouchEndedBlock touchEndedBlock;

- (instancetype)initWithFrame:(CGRect)frame Type:(YCButtonType)type;
- (void)setTitle:(NSString *)title;
//- (void)setTitle:(NSString *)title forState:(UIControlState)state;
//- (void)setTitle:(NSString *)title forState:(UIControlState)state;

@end
