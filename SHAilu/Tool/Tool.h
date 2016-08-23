//
//  Tool.h
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

#ifndef Tool_h
#define Tool_h

//宏定义
#define DefaultTag      10000

//height
#define ScreenWith   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenScale  375.0 / CGRectGetWidth([UIScreen mainScreen].bounds)

#define NVH         44
#define SBH         20
#define TBH         49

//color
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//block
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define Dedug 1
// 日志打印
#if Dedug
#define YCLog(fmt, ...) NSLog((@"%@ : " fmt), NSStringFromClass([self class]), ##__VA_ARGS__)
#else
#define YCLog(...)
#endif

//FIXME: 建议以后将所有颜色（即使是系统颜色）提出出来，方便统一更换风格

//custom
#define ScreenWithOutBarsSize   CGRectMake(0, 0, ScreenWith, ScreenHeight-64-49)
#define ScreenWithOutNavSize    CGRectMake(0, 0, ScreenWith, ScreenHeight-64)


//---------------------------color---------------------------------
#define YCItemColor       [UIColor colorWithRed:0.090 green:0.027 blue:0.004 alpha:1.000]
#define YCNavTitleColor       [UIColor colorWithRed:0.686 green:0.561 blue:0.259 alpha:1.000]

#define YCBlackColor     [UIColor colorWithWhite:0.200 alpha:1.000]
#define YCGrayColor      [UIColor colorWithWhite:0.400 alpha:1.000]
#define YCLightGrayColor [UIColor colorWithWhite:0.600 alpha:1.000]

#define YCButtonDisableColor   YCLightGrayColor
#define YCCellLineColor        [UIColor colorWithWhite:0.941 alpha:1.000]
#define YCViewBackColor        YCCellLineColor
#define YCThemeColor           YCItemColor
//-----------------------------------------------------------------



//----------------------------method-------------------------------
#define DismissAction     - (void)dissmissAction{\
[self.navigationController dismissViewControllerAnimated:YES completion:nil];\
}

//-----------------------------------------------------------------
//#define BaseURL    @"http://iost.ibaozhuang.com/"
#define BaseURL    @"http://192.168.0.156:8200/"
#define PGY_APP_ID @"9848cb41e160d92e1173b69bd5185efa"

//头文件
#import "Factory.h"
#import <POP/POP.h>
#import "FLAnimatedImage.h"
#import "NSObject+Security.h"
//#import "OhterLib.h"
//#import "BaseAPI.h"
#import "Category.h"
//#import "Function.h"
#import "NetWorking.h"
#import "BaseAPI.h"
#import "UserModel.h"

//otherLib
#import "MBProgressHUD+MJ.h"

#endif /* Tool_h */
