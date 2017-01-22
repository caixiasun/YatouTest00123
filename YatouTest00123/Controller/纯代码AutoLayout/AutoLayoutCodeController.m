//
//  AutoLayoutCodeController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/20.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "AutoLayoutCodeController.h"

@interface AutoLayoutCodeController ()

@end

@implementation AutoLayoutCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *leftButton = [UIButton new];
    [leftButton setTitle:@"左边" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftButton.layer.borderColor = [UIColor blackColor].CGColor;
    leftButton.layer.borderWidth = 0.5;
    leftButton.backgroundColor = [UIColor greenColor];
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [UIButton new];
    [rightButton setTitle:@"右边" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightButton.layer.borderColor = [UIColor blackColor].CGColor;
    rightButton.layer.borderWidth = 0.5;
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rightButton];
    
    NSMutableDictionary *viewsDic = [NSMutableDictionary new];
    viewsDic[@"leftButton"] = leftButton;
    viewsDic[@"rightButton"] = rightButton;
    
    //数字参数
    NSMutableDictionary *metricsDictM = [NSMutableDictionary dictionary];
//
    NSMutableArray *stringArray = [NSMutableArray new];
    [stringArray addObject:@"H:|-30-[leftButton(==150)]-20-[rightButton]"];
    [stringArray addObject:@"V:|-100-[leftButton(==40)]-[rightButton]"];
    [stringArray addObject:@"H:[rightButton(leftButton)]"];
    [stringArray addObject:@"V:[rightButton(leftButton)]"];
    
    
    NSMutableArray *constraintsArray = [NSMutableArray new];
    for (NSString *string in stringArray) {
        NSArray *arr = [NSLayoutConstraint constraintsWithVisualFormat:string options:0 metrics:metricsDictM views:viewsDic];
        [constraintsArray addObjectsFromArray:arr];
    }
    
    [self.view addConstraints:constraintsArray];
    
}


@end
