//
//  Demo4Controller.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "Demo4Controller.h"
#import "DMHeartFlyView.h"

@interface Demo4Controller ()

@end

@implementation Demo4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
       
}

//支持旋转
- (BOOL)shouldAutorotate {
    return  YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

//开始的方向 重要
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - action method
- (IBAction)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1://返回
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case 2://送礼物
        {
            DMHeartFlyView *heart = [[DMHeartFlyView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            heart.center= sender.center;
            [heart animateInView:self.view];
            [self.view addSubview:heart];
            break;
        }
        case 3://发送评论
        {
            break;
        }
        default:
            break;
    }
}

- (void)sendGift {
    
}


@end
