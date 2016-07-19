//
//  CustomButton.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.frame = self.frame;
        self.titleLabel.font = [UIFont yc_systemFontOfSize:13];
        self.titleLabel.backgroundColor = [UIColor greenColor];
    }
    return self;
}

//- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//     NSLog(@"beginTrackingWithTouch");
//    return YES;
//}
//
//- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
//     NSLog(@"endTrackingWithTouch");
//    
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
    anim.springBounciness = 4.0;
    anim.springSpeed = 12.0;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {NSLog(@"Animation finished!");}};
    [self.layer pop_addAnimation:anim forKey:@"YCButtonScaleXY"];

    self.titleLabel.font = [UIFont yc_systemFontOfSize:14];
    
    
    
    
    
    
//    POPSpringAnimation *lableAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    lableAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
//    lableAnim.springBounciness = 4.0;
//    lableAnim.springSpeed = 12.0;
//    lableAnim.completionBlock = ^(POPAnimation *lableAnim, BOOL finished) {
//        if (finished) {NSLog(@"Animation finished!");}};
//    [self.titleLabel.layer pop_addAnimation:lableAnim forKey:@"YCButtonScaleXY"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     NSLog(@"touchesEnded");
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    anim.springBounciness = 4.0;
    anim.springSpeed = 12.0;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {NSLog(@"Animation finished!");}};
    [self.layer pop_addAnimation:anim forKey:@"YCButtonScaleXY"];
    
//    POPSpringAnimation *lableAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    lableAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//    lableAnim.springBounciness = 4.0;
//    lableAnim.springSpeed = 12.0;
//    lableAnim.completionBlock = ^(POPAnimation *lableAnim, BOOL finished) {
//        if (finished) {NSLog(@"Animation finished!");}};
//    [self.titleLabel.layer pop_addAnimation:lableAnim forKey:@"YCButtonScaleXY"];
    
    
    

}

@end
