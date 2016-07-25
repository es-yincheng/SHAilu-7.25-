//
//  AnimationFactory.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "AnimationFactory.h"

@implementation AnimationFactory

- (POPSpringAnimation *)moveToY:(CGFloat)y{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    spring.toValue = @(y);
    spring.beginTime = CACurrentMediaTime();
    spring.springBounciness = 0.0f;
    return spring;
}

- (CABasicAnimation *)rotate{
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    circleAnimation.duration = 2.5f;
    circleAnimation.repeatCount = MAXFLOAT;
    circleAnimation.toValue = @(M_PI*2);
    return circleAnimation;
}

@end
