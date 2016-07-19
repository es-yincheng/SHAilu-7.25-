//
//  MaskView.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "MaskView.h"

@interface MaskView()

@property (nonatomic, strong) CAShapeLayer *maskLayerUp;

@end

@implementation MaskView

- (CALayer *)greenHeadMaskLayer{
    CALayer *mask = [CALayer layer];
    mask.frame = self.contentView.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = mask.bounds;
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                           radius:15.0f
                                                       startAngle:0
                                                         endAngle:2*M_PI
                                                        clockwise:YES].CGPath;
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];

    return mask;
}

- (void)startGreenHeadAnimation{
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    downAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(10.0f, 10.0f)];
    downAnimation.duration = 2.0;
    [self.maskLayerUp addAnimation:downAnimation forKey:@"downAnimation"];
}

@end
