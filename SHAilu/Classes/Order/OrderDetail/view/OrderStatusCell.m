//
//  OrderStatusCell.m
//  SHAilu
//
//  Created by 尹成 on 16/8/18.
//  Copyright © 2016年 尹成. All rights reserved.
//

typedef NS_ENUM(NSInteger, OrderStatus) {
    OrderStatusQuote = 0,
    OrderStatusYinShua,
    OrderStatusZhiTong,
    OrderStatusHuDi,
    OrderStatusGanZao,
    OrderStatusDaBao,
    OrderStatusPeiSong,
    OrderStatusEnd
};

#define LineColor [UIColor colorWithRed:0.090 green:0.027 blue:0.004 alpha:0.800]

#import "OrderStatusCell.h"

@interface OrderStatusCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation OrderStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithData:(id)data index:(NSInteger)index{
    NSDictionary *dict = [data yc_objectAtIndex:index];
    
    _title.text = [dict yc_objectForKey:@"Description"];
    _time.text = [dict yc_objectForKey:@"time"];
    
    switch (index) {
        case OrderStatusQuote:
            NSLog(@"OrderStatusQuote");
            break;
            
        case OrderStatusYinShua:
            NSLog(@"OrderStatusYinShua");
            break;
            
        case OrderStatusZhiTong:
            NSLog(@"OrderStatusZhiTong");
            break;
            
        case OrderStatusHuDi:
            NSLog(@"OrderStatusHuDi");
            break;
            
        case OrderStatusGanZao:
            NSLog(@"OrderStatusGanZao");
            break;
            
        case OrderStatusDaBao:
            NSLog(@"OrderStatusDaBao");
            break;
            
        case OrderStatusPeiSong:
            NSLog(@"OrderStatusPeiSong");
            break;
            
        case OrderStatusEnd:
            NSLog(@"OrderStatusEnd");
            break;
            
        default:
            break;
    }
    
    if (index == 0) {
        
        if ([data count] == 1) {
            _topLine.hidden = YES;
            _buttomLine.hidden = YES;
            _title.textColor = YCNavTitleColor;
            _time.textColor = YCNavTitleColor;
            _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"orderstatus_%ld_1",(long)9-index]];
        } else {
            _topLine.hidden = YES;
            _buttomLine.hidden = NO;
            _title.textColor = YCNavTitleColor;
            _time.textColor = YCNavTitleColor;
            _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"orderstatus_%ld_1",(long)9-index]];
        }
        
    } else if (index == [data count] - 1) {
        _topLine.hidden = NO;
        _buttomLine.hidden = YES;
        _title.textColor = [UIColor blackColor];
        _time.textColor = [UIColor lightGrayColor];
        _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"orderstatus_%ld_0",(long)9-index]];
    } else {
        _topLine.hidden = NO;
        _buttomLine.hidden = NO;
        _title.textColor = [UIColor blackColor];
        _time.textColor = [UIColor lightGrayColor];
        _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"orderstatus_%ld_0",(long)9-index]];
    }
}

@end
