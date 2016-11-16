//
//  OtherController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "OtherController.h"

@interface OtherController ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSMutableArray *linkDataSource;
@property (nonatomic, strong) UIImageView *linkImgView;

@end

@implementation OtherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self alphaMethod];
    
    [self cadisplaylinkTest];
    
}

//CADisplayLink测试
- (void)cadisplaylinkTest {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 200, 50);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(linkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkUpdate)];
    link.paused = YES;
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.link = link;
    
    self.linkDataSource = [NSMutableArray new];
    for (int i=0; i<100; i++) {
        [self.linkDataSource addObject:[NSString stringWithFormat:@"balloon%d.png",i]];
    }
    
    UIImageView *imgV = [UIImageView new];
    imgV.frame = self.view.bounds;
    imgV.center = self.view.center;
    [self.view addSubview:imgV];
    self.linkImgView = imgV;
    
}

- (void)linkAction {
    self.link.paused = NO;
}

- (void)linkUpdate {
    static int num = 0;
    
    if (num < self.linkDataSource.count) {
        UIImage *image = [UIImage imageNamed:[self.linkDataSource objectAtIndex:num]];
        self.linkImgView.image = image;
        num++;
    }else {
        self.link.paused = YES;
        [self.link invalidate];
        self.link = nil;
    }
}

//只改变父视图的alpha，不改变子视图的。
- (void)alphaMethod {
    UIView *v1 = [UIView new];
    v1.frame = CGRectMake(20, 100, 200, 200);
    v1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.3];
    //    v1.alpha = .3;
    [self.view addSubview:v1];
    
    UIView *v2 = [UIView new];
    v2.frame = CGRectMake(10, 10, 50, 50);
    v2.backgroundColor = [UIColor greenColor];
    [v1 addSubview:v2];
}

@end
