//
//  ThirdLoginController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/12.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ThirdLoginController.h"

@interface ThirdLoginController ()

@end

@implementation ThirdLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *wbBtn = [UIButton new];
    [wbBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [wbBtn setTitle:@"微博登录" forState:UIControlStateNormal];
    [wbBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    wbBtn.tag = 2;
    [self.view addSubview:wbBtn];
    
}

- (void)buttonAction:(UIButton *)button {
    switch (button.tag) {
        case 2://weibo login
        {
            break;
        }
        default:
            break;
    }
}


@end
