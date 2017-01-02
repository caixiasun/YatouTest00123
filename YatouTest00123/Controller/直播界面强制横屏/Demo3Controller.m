//
//  Demo3Controller.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "Demo3Controller.h"
#import "PureLayout.h"
#import "Demo4Controller.h"
#import "TestHeartView.h"

@interface Demo3Controller ()

@end

@implementation Demo3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 160, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"去Demo4" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    TestHeartView *testV = [[TestHeartView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    testV.center = self.view.center;
    [self.view addSubview:testV];
    
}

- (void)btnClicked {
    Demo4Controller *vc = [Demo4Controller new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//支持旋转
- (BOOL)shouldAutorotate {
    return  YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

////开始的方向 重要
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
