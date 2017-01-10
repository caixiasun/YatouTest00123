//
//  TimerDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/9.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "TimerDemoController.h"

@interface TimerDemoController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timer_init_type;

@end

@implementation TimerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *pauseBtn = [UIButton new];
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pauseBtn.tag = 2;
    [pauseBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    [self setBorder:pauseBtn];
    [pauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.offset = 80;
    }];
    
    UIButton *startBtn = [UIButton new];
    [startBtn setTitle:@"开启" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    startBtn.tag = 1;
    [startBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [self setBorder:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pauseBtn);
        make.right.equalTo(pauseBtn.mas_left).offset = -10;
        make.width.equalTo(pauseBtn);
    }];
    
    UIButton *endBtn = [UIButton new];
    [endBtn setTitle:@"停止" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    endBtn.tag = 3;
    [endBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    [self setBorder:endBtn];
    [endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pauseBtn);
        make.left.equalTo(pauseBtn.mas_right).offset = 10;
        make.width.equalTo(pauseBtn);
    }];
}

- (NSTimer *)timer {
    if (!_timer) {
        switch (_timer_init_type) {
            case 0:
            {
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                break;
            }
            default:
                break;
        }
    }
    return _timer;
}

- (void)timerAction {
    NSLog(@"_________timer(%ld) 执行了...",_timer_init_type);
}

- (void)buttonAction:(UIButton *)button {
    button.selected = !button.selected;
    switch (button.tag) {
        case 1://start
        {
            NSLog(@"创建定时器...");
            self.timer.fireDate = [NSDate distantPast];//启动
            break;
        }
        case 2://pause
        {
            if (button.selected) {
                NSLog(@"暂停定时器...");
                [button setTitle:@"继续" forState:UIControlStateNormal];
                self.timer.fireDate = [NSDate distantFuture];
            }else {
                NSLog(@"继续定时器...");
               [button setTitle:@"暂停" forState:UIControlStateNormal];
                self.timer.fireDate = [NSDate distantPast];
            }
            break;
        }
        case 3://end
        {
            NSLog(@"终止定时器...");
            [self.timer invalidate];
            self.timer = nil;
            break;
        }
        default:
            break;
    }
}

- (void)setBorder:(UIView *)view {
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 0.5;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}


@end
