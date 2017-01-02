//
//  CircleProgressController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/14.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "CircleProgressController.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 20 //弧线的宽度
#define PROCESS_COLOR [UIColor purpleColor]

@interface CircleProgressController ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation CircleProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(50, 150, 200, 200);
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    _strokeColor = [UIColor greenColor];
    
//    _trackLayer = [CAShapeLayer layer];//创建一个track shape layer
//    _trackLayer.frame = view.bounds;
//    [view.layer addSublayer:_trackLayer];
//    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
//    _trackLayer.strokeColor = [_strokeColor CGColor];//指定path的渲染颜色
//    _trackLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
//    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
//    _trackLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:degreesToRadians(-210) endAngle:degreesToRadians(30) clockwise:YES];//上面说明过了用来构建圆形
//    _trackLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = view.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [PROCESS_COLOR CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 0.9;
//    [view.layer addSublayer:_progressLayer];
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, view.frame.size.width/2, view.frame.size.height);
    gradientLayer1.position = CGPointMake(20, 30);
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[[UIColor greenColor] CGColor],(id)[[UIColor yellowColor] CGColor], nil]];
    [gradientLayer1 setLocations:@[@0.5,@0.9,@1 ]];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    [gradientLayer2 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer2.frame = CGRectMake(view.frame.size.width/2, 0, view.frame.size.width/2, view.frame.size.height);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor blueColor] CGColor], nil]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer2];

    [gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [view.layer addSublayer:gradientLayer];
}


@end
