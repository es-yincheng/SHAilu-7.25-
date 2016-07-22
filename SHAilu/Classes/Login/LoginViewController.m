//
//  LoginViewController.m
//  SHAilu
//
//  Created by 尹成 on 16/7/14.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "YGGravityImageView.h"

@interface LoginViewController (){
    BOOL canLogin;
}

@property (weak, nonatomic) IBOutlet UILabel *xline;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) YGGravityImageView *imageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[YGGravityImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.image = [UIImage imageNamed:@"backImage"];
    [self.view addSubview:_imageView];
    
    [self.view addSubview:self.loginButton];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_imageView startAnimate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_imageView stopAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - custom
- (void)setNavigation{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setLoginButton{
    _loginButton.layer.cornerRadius = 8.f;
    _loginButton.layer.masksToBounds = YES;
    _loginButton.frame = CGRectMake(40, self.xline.yc_y + 50 + 45, ScreenWith - 80, 50);
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor orangeColor];
}

#pragma mark - action
- (void)registerAction{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(UIButton *)sender {
    UIButton *btn = sender;
    [UIView animateWithDuration:0.5f animations:^{
        [btn setTitle:@"" forState:UIControlStateNormal];
        CGPoint center = btn.center;
        btn.frame = CGRectMake(0, 0, 40, 40);
        btn.layer.cornerRadius = 20;
        btn.center = center;
        
    }completion:^(BOOL finished) {
        
        CAShapeLayer *circle = [CAShapeLayer new];
        circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0,0) radius:btn.bounds.size.width/2+2 startAngle:0 endAngle:M_PI*2*0.9 clockwise:YES].CGPath;
        circle.strokeColor = [UIColor greenColor].CGColor;
        circle.fillColor = [UIColor clearColor].CGColor;
        circle.lineWidth = 3.f;
        circle.position = btn.center;
        [self.view.layer addSublayer:circle];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
        anim.fromValue = [NSNumber numberWithFloat:0];
        anim.toValue = [NSNumber numberWithFloat:0.9];
        anim.duration = 1;
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished) {
                
                CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                circleAnimation.duration = 2.5f;
                circleAnimation.repeatCount = MAXFLOAT;
                circleAnimation.toValue = @(M_PI*2);
                [circle addAnimation:circleAnimation forKey:@"rotation"];
                
                if (canLogin) {
                    [circle removeFromSuperlayer];
                    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
                    [btn pop_addAnimation:anim forKey:@"scaleAnimationKey"];
                    anim.completionBlock = ^(POPAnimation *animation,BOOL finish) {
                        NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
                        [userDefualts setValue:@"user" forKey:@"UserInfo"];
                        [userDefualts synchronize];
                        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
                    };
                } else {
                    [[BaseAPI sharedAPI].userService loginWithUserName:nil
                                                              Password:nil
                                                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                   [circle removeFromSuperlayer];
                                                                   POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                                                                   anim.toValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
                                                                   [btn pop_addAnimation:anim forKey:@"scaleAnimationKey"];
                                                                   anim.completionBlock = ^(POPAnimation *animation,BOOL finish) {
                                                                       NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
                                                                       [userDefualts setValue:@"user" forKey:@"UserInfo"];
                                                                       [userDefualts synchronize];
                                                                       [self.navigationController dismissViewControllerAnimated:NO completion:nil];
                                                                   };
                                                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                   [NSThread sleepForTimeInterval:3.0];
                                                                   [MBProgressHUD showError:@"网络连接失败"];
                                                                   canLogin = YES;
                                                                   [circle removeFromSuperlayer];
                                                                   [UIView animateWithDuration:1.f animations:^{
                                                                       [self setLoginButton];
                                                                   }completion:^(BOOL finished) {
                                                                       
                                                                   }];
                                                               }];
                }                
            }
        };
        [circle pop_addAnimation:anim forKey:@"YCButtonScaleXY"];
    }];
}

#pragma mark - lazy
- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(40, self.xline.yc_y + 45, ScreenWith-80, 50)];
        [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self setLoginButton];
    }
    return _loginButton;
}


@end
