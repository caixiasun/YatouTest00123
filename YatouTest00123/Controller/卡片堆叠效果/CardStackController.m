//
//  CardStackController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/3.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "CardStackController.h"
#import "CardStackView.h"

@interface CardStackController ()

@end

@implementation CardStackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:[[CardStackView alloc] initWithFrame:self.view.bounds]];
    
    UIView *tabBarView = [UIView new];
    tabBarView.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
    tabBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85];
    [self.view addSubview:tabBarView];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
    line.backgroundColor = [UIColor blackColor];
    [tabBarView addSubview:line];
    
}


@end
