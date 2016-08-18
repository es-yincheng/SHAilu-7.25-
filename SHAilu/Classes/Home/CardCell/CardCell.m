//
//  CardCell.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "CardCell.h"
//#import "CustomizeController.h"
#import "CustomController.h"
#import "CategoryModel.h"

@interface CardCell(){
    NSInteger bttag;
}

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
//        _backImage.image = [UIImage imageNamed:@"cardBackImage"];
//        _typeIcon.layer.masksToBounds = YES;
//        _typeIcon.layer.cornerRadius = _typeIcon.yc_width/2;
//        _typeIcon.layer.borderColor = [UIColor whiteColor].CGColor;
//        _typeIcon.layer.borderWidth = 2;
    }
    return self;
}

- (void)awakeFromNib{
    NSLog(@"-------");
}

- (void)configWithData:(NSDictionary *)data index:(NSInteger)index{
//    NSArray *images = [data yc_objectForKey:@"image"];
    NSArray *colors = [data yc_objectForKey:@"color"];
    NSArray *titls = [data yc_objectForKey:@"title"];
    NSArray *info = [data yc_objectForKey:@"info"];
    NSArray *descrip = [data yc_objectForKey:@"descrip"];
    
    self.backgroundColor = [colors yc_objectAtIndex:index];
    _typeIcon.image  = [UIImage imageNamed:[NSString stringWithFormat:@"category_%ld",index+1]];
    _title.text      = [titls yc_objectAtIndex:index];
    _info.text       = [info yc_objectAtIndex:index];
    _descrip.text    = [descrip yc_objectAtIndex:index];
    bttag = index;
}


//- (void)setUI{
//            _typeIcon.layer.masksToBounds = YES;
//            _typeIcon.layer.cornerRadius = _typeIcon.yc_width/2;
//            _typeIcon.layer.borderColor = [UIColor whiteColor].CGColor;
//            _typeIcon.layer.borderWidth = 2;
//}

- (IBAction)customAction:(UIButton *)sender {
    
    NSLog(@"self.tag:%ld",(long)bttag);
    
    CustomController *vc = [[CustomController alloc] init];
    vc.startData = [CategoryModel getChildCategoryById:bttag];
    [self.viewController.navigationController pushViewController:vc animated:YES];
    YCTabBarController *tabBarController = (YCTabBarController*)self.viewController.tabBarController;
    tabBarController.customView.hidden = YES;
}

@end
