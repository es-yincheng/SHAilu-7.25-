//
//  UIImage+Custom.m
//  SHAilu
//
//  Created by 尹成 on 16/8/22.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "UIImage+Custom.h"

@implementation UIImage (Custom)

- (NSString *)compressWithScale:(float)scale{
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    while (imageData.length/1024.0/1024.0 > 0.6f) {
        UIImage *temImage = [UIImage imageWithData:imageData];
        imageData = [self imageWithImage:temImage scaledToSize:CGSizeMake(temImage.size.width*0.9, temImage.size.height*0.9)];
    }
    
    NSString *picString = [imageData base64EncodedStringWithOptions:0];
    NSString *pic64String = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                          (CFStringRef)picString,
                                                                                          NULL,
                                                                                          CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                          kCFStringEncodingUTF8);
    
    return pic64String;
}

- (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.9);
}

@end
