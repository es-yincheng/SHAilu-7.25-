//
//  SpecsCell.m
//  SHAilu
//
//  Created by 尹成 on 16/8/15.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "SpecsCell.h"

@interface SpecsCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *changeStatuBt;

@end

@implementation SpecsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // NSLog(@"cellForRowAtIndexPath");
    static NSString *identifier = @"SpecsCell";
    // 1.缓存中取
    SpecsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[SpecsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.backView addSubview:self.changeStatuBt];
        
        
        
        
        
        [self.contentView addSubview:_backView];
    }
    return self;
}

#pragma mark - action
//- (IBAction)changeStatu:(UIButton *)sender{
//    
//}

- (void)changeStatu:(CellStatu)statu{
    switch (statu) {
        case CellStatuOpen:
        {
            [_changeStatuBt setTitle:@"StatusOpen" forState:UIControlStateNormal];
        }
            break;
            
        default:
        {
            [_changeStatuBt setTitle:@"StatusClose" forState:UIControlStateNormal];
        }
            break;
    }
}

#pragma mark - lazy
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.frame];
    }
    return _backView;
}

- (UIButton *)changeStatuBt{
    if (!_changeStatuBt) {
        _changeStatuBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 38)];
        _changeStatuBt.backgroundColor = YCNavTitleColor;
        [_changeStatuBt setTitle:@"changeStatus" forState:UIControlStateNormal];
    }
    return _changeStatuBt;
}

- (void)configWithModel:(id)model{
    NSArray *materials = [model yc_objectForKey:@"material"];
    
    if ([[model yc_objectForKey:@"type"] isEqualToString:@"main"]) {
        
    } else {
        
    }
}

@end
