//
//  CustomController.h
//  SHAilu
//
//  Created by 尹成 on 16/8/8.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomController : UIViewController

@property (nonatomic, strong) NSArray      *startData;
@property (nonatomic, strong) NSString     *parentCategoryName;
@property (nonatomic, assign) NSInteger    startIndex;
@property (nonatomic, strong) NSDictionary *specsDict;

@end
