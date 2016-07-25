//
//  YCPhotoBrowserCell.h
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCPhotoBrowserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labCount;

@end
