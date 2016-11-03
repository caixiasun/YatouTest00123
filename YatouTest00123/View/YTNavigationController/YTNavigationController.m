//
//  YTNavigationController.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTNavigationController.h"

@interface YTNavigationController ()

@end

@implementation YTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//支持旋转
- (BOOL)shouldAutorotate {
    return  [self.topViewController shouldAutorotate];
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end
