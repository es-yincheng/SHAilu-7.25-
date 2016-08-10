//
//  MessageLeftCell.m
//  SHAilu
//
//  Created by 尹成 on 16/8/10.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "MessageLeftCell.h"

@implementation MessageLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 6;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (UIView*)bubbleView:(NSString*)text imageName:(NSString*)name
//{
//    UIView *returnView=[[UIView alloc]initWithFrame:CGRectZero];
//    UIImage*bubble;
//    returnView.backgroundColor=[UIColor clearColor];//ImageBubble@2x~iphone
//    if([name isEqualToString:@"1"]){//bubble-default-outgoing@2x
//        bubble=[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"bubble-default-incoming-green@2x"ofType:@"png"]]resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f,25.0f,16.0f,23.0f)];
//    }else{
//        bubble=[[UIImage imageNamed:@"ImageBubble~iphone"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
//    }
//    UIImageView *bubbleImageView=[[UIImageView alloc]initWithImage:bubble];
//    UIFont *font=[UIFont systemFontOfSize:13];
//    CGSize size=[text sizeWithFont:font constrainedToSize:CGSizeMake(220.0f,1000.0f)lineBreakMode: NSLineBreakByWordWrapping];
//    CGSize new1=[text sizeWithFont:font constrainedToSize:CGSizeMake(220.0f,size.height)lineBreakMode: NSLineBreakByWordWrapping];
//    UILabel*bubbleText;
//    if([name isEqualToString:@"1"]){
//        bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(12.0f,5.0f,new1.width+10,new1.height+10)];
//    }else{
//        bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(5.0f,5.0f,new1.width+10,new1.height+10)];
//    }
//    bubbleText.backgroundColor=[UIColor clearColor];
//    bubbleText.font=font;
//    bubbleText.numberOfLines=0;
//    bubbleText.lineBreakMode=NSLineBreakByWordWrapping;
//    bubbleText.text=text;
//    bubbleImageView.frame=CGRectMake(0.0f,0.0f,new1.width+20, new1.height+20.0f);
//    if([name isEqualToString:@"1"]){
//        returnView.frame=CGRectMake(40.0f,30.0f,new1.width+20, new1.height+20.0f);
//    }else{
//        returnView.frame=CGRectMake(260.0f-new1.width,40.0f,new1.width+20, new1.height+20.0f);
//    }
//    [returnView addSubview:bubbleImageView];
//    [returnView addSubview:bubbleText];
//    return returnView;
//}




@end
