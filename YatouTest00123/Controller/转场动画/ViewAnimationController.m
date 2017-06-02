//
//  ViewAnimationController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/7.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ViewAnimationController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewAnimationController ()
{
    BOOL _flag;
    UIView *_lastView;
}



@end

@implementation ViewAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _flag = true;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.center = self.view.center;
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    _lastView = view;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_flag) {
        _lastView.backgroundColor = [UIColor redColor];
    }else {
        _lastView.backgroundColor = [UIColor greenColor];
    }
    _flag = !_flag;
    
    CATransition *transition = [CATransition animation];
    transition.type = @"pageCurl";
    transition.subtype = @"fromLeft";
    [_lastView.layer addAnimation:transition forKey:nil];
}


@end
