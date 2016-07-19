//
//  Factory.h
//  IBZApp
//
//  Created by 尹成 on 16/7/8.
//  Copyright © 2016年 ibaozhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIFactory.h"
#import "MethodFactory.h"

@interface Factory : NSObject

@property (strong, nonatomic) UIFactory     *uiFactory;
@property (strong, nonatomic) MethodFactory *methodFactory;

+ (UIFactory *)sharedUI;
+ (MethodFactory *)sharedMethod;

@end
