//
//  ViewGradientController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/14.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "SimpleGradientController.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_RATIO 40

@interface SimpleGradientController ()
{
    CGRect _testFrame;
}
@end

@implementation SimpleGradientController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _testFrame = CGRectMake(10, 250, 200, 50);
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:_testFrame];
    imgV.image = [self gradientWithCIF];
    imgV.tag = 222;
    [self.view addSubview:imgV];
    
    /*
    //关联值  测试
    //核心方法：
    //objc_setAssociatedObject  /  objc_getAssociatedObject
    NSString *message = @"我是被关联的值，来测试吧~~";
    objc_setAssociatedObject(self.view, @"view", message, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self.view, @"imageView", imgV, OBJC_ASSOCIATION_ASSIGN);
     */
    
    {
        UIView *view = [UIView new];
        view.frame = CGRectMake(10, 70, 200, 50);
        [self.view addSubview:view];
        CAGradientLayer *gradientLayer = [CAGradientLayer new];
        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
        gradientLayer.startPoint = CGPointMake(0.5, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.bounds = view.bounds;
        gradientLayer.center = view.center;
        [view.layer addSublayer:gradientLayer];
    }
    
}



- (UIImage *)gradientWithCIF
{
    NSMutableArray *ar = [NSMutableArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor purpleColor].CGColor, nil];
    //创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)。参数size为新创建的位图上下文的大小。该函数的功能同UIGraphicsBeginImageContextWithOptions的功能相同，相当与UIGraphicsBeginImageContextWithOptions的opaque参数为NO,scale因子为1.0。
    //虽然这里可以用[UIScreen mainScreen].scale来获取，但实际上设为0后，系统就会自动设置正确的比例了。
    UIGraphicsBeginImageContextWithOptions(_testFrame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace((CGColorRef)[ar lastObject]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    int gradientType = 4;
    switch (gradientType) {
            //上下渐变
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, _testFrame.size.height);
            break;
        case 1:
            //左右渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(_testFrame.size.width, 0.0);
            break;
        case 2:
            //对角两侧渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(_testFrame.size.width, _testFrame.size.height);
            break;
        case 3:
            //对角两侧渐变
            start = CGPointMake(_testFrame.size.width, 0.0);
            end = CGPointMake(0.0, _testFrame.size.height);
            break;
        case 4:
            //线性渐变
            start = CGPointMake(_testFrame.size.width/2, _testFrame.size.height/2);
            end = CGPointMake(_testFrame.size.width/2, _testFrame.size.height/2);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    if (gradientType == 4) {
        CGContextDrawRadialGradient(context, gradient, start, 10, end, _testFrame.size.width/3, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
 
}

- (IBAction)btnAction:(id)sender {
    /*
     NSString *mess = objc_getAssociatedObject(self.view, @"view");
     NSLog(@"________%@",mess);
     UIImageView *imgV = objc_getAssociatedObject(self.view, @"imageView");
     NSLog(@"_______%ld",(long)imgV.tag);
     */
}

@end
