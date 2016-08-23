//
//  SpecCell.h
//  SHAilu
//
//  Created by 尹成 on 16/8/16.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CellStatu) {
    CellStatuOpen = 0,
    CellStatuClose
};
@interface SpecCell : UITableViewCell
- (void)configWithModel:(id)model;
- (void)changeStatu:(CellStatu)statu;
- (NSDictionary *)getDataDict;
@end
