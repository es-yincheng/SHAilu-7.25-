//
//  CardCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CardCell.h"
#import "CustomizeController.h"

@interface CardCell()

@property (weak, nonatomic) IBOutlet UILabel     *typeName;
@property (weak, nonatomic) IBOutlet UILabel     *typeInfo;
@property (weak, nonatomic) IBOutlet UILabel     *typeDetail;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation CardCell

- (instancetype)initWithFrame:(CGRect)frame{
    
     self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CardCell" owner:self options:nil] lastObject];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 20;
        _backImage.image = [UIImage imageNamed:@"cardBackImage"];
        _typeIcon.layer.masksToBounds = YES;
        _typeIcon.layer.cornerRadius = _typeIcon.yc_width/2;
        _typeIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        _typeIcon.layer.borderWidth = 2;
    }
    return self;
}

- (void)awakeFromNib{
    NSLog(@"-------");
}




//- (void)setUI{
//            _typeIcon.layer.masksToBounds = YES;
//            _typeIcon.layer.cornerRadius = _typeIcon.yc_width/2;
//            _typeIcon.layer.borderColor = [UIColor whiteColor].CGColor;
//            _typeIcon.layer.borderWidth = 2;
//}

- (IBAction)customAction:(id)sender {
    CustomizeController *vc = [[CustomizeController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.viewController.tabBarController;
    tabBarController.customView.hidden = YES;
}

@end
