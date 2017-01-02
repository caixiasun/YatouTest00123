//
//  Demo2Controller.m
//  YatouTest00123
//
//  Created by caixiasun on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "Demo2Controller.h"
#import "YTCalendarView.h"

@interface Demo2Controller ()

@end

@implementation Demo2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat value = 0.9;
    self.view.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:1];
    YTCalendarView *calendar = [[YTCalendarView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, YTCalendarView_Height)];
    [self.view addSubview:calendar];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
