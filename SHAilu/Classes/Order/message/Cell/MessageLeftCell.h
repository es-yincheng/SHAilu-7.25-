//
//  MessageLeftCell.h
//  SHAilu
//
//  Created by 尹成 on 16/8/10.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageLeftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLb;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewWidth;
@end
