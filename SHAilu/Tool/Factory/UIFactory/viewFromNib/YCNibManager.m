//
//  YCNibManager.m
//  SHAilu
//
//  Created by 尹成 on 16/7/25.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "YCNibManager.h"

@interface YCNibManager()

@property (copy ,nonatomic) NSString *nibName;
@property (weak ,nonatomic) IBOutlet UIView *view;
@property (weak ,nonatomic) IBOutlet UIView *cardCell;

@end

@implementation YCNibManager

- (id)initWithNib:(NSString *)nibName{
    if (self = [super init]) {
        self ->_nibName = nibName;
    }
    
    return self;
}

- (UIView *)loadView{
    [[NSBundle mainBundle] loadNibNamed:self->_nibName owner:self options:nil];
    return self.view;
}

+ (UIView *)loadCardCell{
    YCNibManager *manager = [[YCNibManager alloc] initWithNib:@"CardCell"];
    return [manager loadView];
}

@end
