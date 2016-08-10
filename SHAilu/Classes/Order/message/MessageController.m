//
//  MessageController.m
//  SHAilu
//
//  Created by 尹成 on 16/8/8.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "MessageController.h"
//#import "MessageLeftCell.h"
//#import "MessageRightCell.h"

//#import "UIBubbleTableView.h"
//#import "UIBubbleTableViewDataSource.h"
//#import "NSBubbleData.h"
//
//NSString *MessageLeft = @"MessageLeftCell";
//NSString *MessageRight = @"MessageRightCell";

#import "JSQMessagesViewAccessoryButtonDelegate.h"

@interface MessageController ()<JSQMessagesViewAccessoryButtonDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
//    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}























//#pragma setUI
//- (void)setTableView{
//    [_tableView registerNib:[UINib nibWithNibName:MessageLeft bundle:nil] forCellReuseIdentifier:MessageLeft];
//    [_tableView registerNib:[UINib nibWithNibName:MessageRight bundle:nil] forCellReuseIdentifier:MessageRight];
//    _tableView.estimatedRowHeight = 40;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//}
//
//#pragma mark - delegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return self.messageArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row%2 == 0) {
//        MessageLeftCell *cell = [_tableView dequeueReusableCellWithIdentifier:MessageLeft];
//        cell.textLb.text = [self.messageArray objectAtIndex:indexPath.row];
//        
//        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
//        CGSize size = [[self.messageArray yc_objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake(ScreenWith-(50+55), 999)
//                                                                                     options: NSStringDrawingUsesLineFragmentOrigin
//                                                                                  attributes:attribute context:nil].size;
//        cell.backViewWidth.constant = size.width;
//        cell.backViewHeight.constant = size.height;
//    
//        return cell;
//    } else {
//        MessageRightCell *cell = [_tableView dequeueReusableCellWithIdentifier:MessageRight];
//        cell.textLb.text = [self.messageArray objectAtIndex:indexPath.row];
//        
//        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
//        CGSize size = [[self.messageArray yc_objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake(ScreenWith-(27+8)-(15+45), 999)
//                                                                                       options: NSStringDrawingUsesLineFragmentOrigin
//                                                                                    attributes:attribute context:nil].size;
//        
//        NSLog(@"text.height:%f ,%f",size.height,size.width);
//        if (size.height > 16) {
//            cell.textLb.textAlignment = NSTextAlignmentLeft;
//        } else {
//            cell.textLb.textAlignment = NSTextAlignmentRight;
//        }
//        
//        return cell;
//    }
//}
//
//#pragma mark - lazy
//- (NSMutableArray *)messageArray{
//    if (!_messageArray) {
//        _messageArray = [[NSMutableArray alloc] init];
//        [_messageArray addObjectsFromArray:@[@"编号:NS99-2324324的订单开始做了吗",@"您好,您的订单已经开始制作",@"帮我再多加工3000件,订金已经安排财务打给你们,合同盖好章回传我们一份",@"好的,稍后财务核对没问题后就开始为您制作合同,如有任何问题,欢迎联系,感谢您的使用"]];
//    }
//    return _messageArray;
//}


@end
