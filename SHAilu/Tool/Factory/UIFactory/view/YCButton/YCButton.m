//
//  YCButton.m
//  SHAilu
//
//  Created by 尹成 on 16/7/13.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCButton.h"

@interface YCButton()<NSObject>

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL   selector;
//@property (nonatomic, strong) id target;
//@property (nonatomic) SEL action;

@end


@implementation YCButton

- (instancetype)initWithFrame:(CGRect)frame Type:(YCButtonType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = 6;
        _titleLable = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont yc_systemFontOfSize:13];
#ifdef YCButtonColor
      self.backgroundColor = YCButtonColor;
      titleLable.textColor = [UIColor whiteColor];
#else
        self.backgroundColor = [UIColor whiteColor];
        _titleLable.textColor = YCBlackColor;
#endif
        [self addSubview:_titleLable];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _titleLable.text = title;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    self.target = target;
    self.selector = action;
}




























- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan");
    if (_touchBeginBlock) {
        _touchBeginBlock();
    } else {
        switch (_buttonType) {
                
            case YCButtonTypeDefault:
            {
                    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.9)];
                    anim.springBounciness = 4.0;
                    anim.springSpeed = 12.0;
                    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                        if (finished) {
//                            NSLog(@"Animation finished!");
                        }
                    };
                    [self.layer pop_addAnimation:anim forKey:@"YCButtonScaleXY"];
                
                POPSpringAnimation *lableAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                lableAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
                lableAnim.springBounciness = 4.0;
                lableAnim.springSpeed = 12.0;
                lableAnim.completionBlock = ^(POPAnimation *lableAnim, BOOL finished) {
                    if (finished) {
//                        NSLog(@"Animation finished!");
//                        if (_target && _action) {
//                            [_target performSelector:_action];
//                        }
                    }
                };
                [_titleLable.layer pop_addAnimation:lableAnim forKey:@"YCButtonScaleXY"];
            }
                break;
                
            case YCButtonTypeAskData:
                
                break;
                
            case YCButtonTypeOther:
                
                break;
                
            default:
                break;
        }
    }
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesMoved");
//}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesEnded");
    if (_touchEndedBlock) {
        _touchEndedBlock();
    } else {
        switch (_buttonType) {
                
            case YCButtonTypeDefault:
            {
                POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
                anim.springBounciness = 4.0;
                anim.springSpeed = 12.0;
                anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                    if (finished) {
//                        NSLog(@"Animation finished!");
                    }
                };
                [self.layer pop_addAnimation:anim forKey:@"YCButtonScaleXY"];
                
                POPSpringAnimation *lableAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                lableAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
                lableAnim.springBounciness = 4.0;
                lableAnim.springSpeed = 12.0;
                lableAnim.completionBlock = ^(POPAnimation *lableAnim, BOOL finished) {
                    if (finished) {
//                        NSLog(@"Animation finished!");
                        if (self.target && self.selector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                            [self.target performSelector:self.selector withObject:self];
#pragma clang diagnostic pop
                        }
                    }
                };
                [_titleLable.layer pop_addAnimation:lableAnim forKey:@"YCButtonScaleXY"];
            }
                break;
                
            case YCButtonTypeAskData:
                
                break;
                
            case YCButtonTypeOther:
                
                break;
                
            default:
                break;
        }
    }
}

//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesCancelled");
//}f

@end
