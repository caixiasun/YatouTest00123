//
//  UIImage+PictureMachine.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "UIImage+PictureMachine.h"

@implementation UIImage (PictureMachine)

//改变图片本身颜色
- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context  多种blendMode均可试试
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
