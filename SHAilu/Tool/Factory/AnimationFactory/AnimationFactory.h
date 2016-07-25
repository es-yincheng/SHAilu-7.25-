//
//  AnimationFactory.h
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <POP/POP.h>

@interface AnimationFactory : NSObject

- (POPSpringAnimation *)moveToY:(CGFloat)y;
- (POPSpringAnimation *)moveToX:(CGFloat)x;
- (CABasicAnimation *)rotate;

@end
