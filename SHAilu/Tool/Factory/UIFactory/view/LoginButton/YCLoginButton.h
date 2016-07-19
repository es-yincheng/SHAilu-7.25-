//
//  YCLoginButton.h
//  SHAilu
//
//  Created by 尹成 on 16/7/12.
//  Copyright © 2016年 尹成. All rights reserved.
//

typedef void(^TouchBeginBlock)();
typedef void(^TouchEndedBlock)();

#import <UIKit/UIKit.h>

@interface YCLoginButton : UIControl

@property (nonatomic, copy) TouchBeginBlock touchBeginBlock;
@property (nonatomic, copy) TouchEndedBlock touchEndedBlock;

@end
