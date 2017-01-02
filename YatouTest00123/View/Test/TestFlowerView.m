//
//  TestFlowerView.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "TestFlowerView.h"

@implementation TestFlowerView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextRef);
    CGContextAddFlower(contextRef, 6, 100, 100, 30, 90);
    CGContextSetRGBFillColor(contextRef, 1, 0, 0, 1);
    CGContextFillPath(contextRef);
    CGContextClosePath(contextRef);
    
    
//    CGContextMoveToPoint(contextRef, 60, 60);
//    CGContextSetLineWidth(contextRef, 2);
//    CGContextSetRGBStrokeColor(contextRef, 0, 0.5, 0.8, 1);
//    CGContextAddEllipseInRect(contextRef, CGRectMake(45, 45, 110, 110));
//    CGContextStrokePath(contextRef);
//    
//    CGContextMoveToPoint(contextRef, 140, 169);
//    CGContextSetLineWidth(contextRef, 1);
//    CGContextSetRGBStrokeColor(contextRef, 1, 0, 0, 1);
//    CGContextAddLineToPoint(contextRef, 0, 0);
//    CGContextStrokePath(contextRef);
}

void CGContextAddFlower(CGContextRef contextRef,NSInteger n,CGFloat dx,CGFloat dy,CGFloat size,CGFloat length)
{
    CGContextMoveToPoint(contextRef, dx, dy+size);
    CGFloat angle = 2*M_PI/n;
    for (int i=1; i<=n; i++)
    {
        CGFloat ctrlX = sin((i-0.5)*angle)*length + dx;
        CGFloat ctrlY = cos((i-0.5)*angle)*length + dy;
        
        CGFloat x = sin(i*angle)*size + dx;
        CGFloat y = cos(i*angle)*size + dy;
        
        CGContextAddQuadCurveToPoint(contextRef, ctrlX, ctrlY, x, y);
        
        
        NSLog(@"dx = %f, dy = %f, ctrlX = %f, ctrlY = %f",dx,dy,ctrlX,ctrlY);
        NSLog(@"distance = %f" , sqrt(pow(dx - ctrlX, 2)+ pow(dy - ctrlY, 2))    );
    }
}


@end
