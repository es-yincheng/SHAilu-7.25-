//
//  SpecsCell.h
//  SHAilu
//
//  Created by 尹成 on 16/8/15.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellStatu) {
    CellStatuOpen = 0,
    CellStatuClose
};

@interface SpecsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configWithModel:(id)model;
- (void)changeStatu:(CellStatu)statu;

@end
