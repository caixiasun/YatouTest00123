//
//  MBProgressHUDController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/22.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "MBProgressHUDController.h"

@interface MBProgressHUDController ()

@property (nonatomic, strong) MBProgressHUD *mbprogressHUD;
@property (nonatomic, assign) NSInteger mode;

@end

@implementation MBProgressHUDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    
    UIButton *button1 = [UIButton new];
    button1.layer.borderColor = [UIColor blackColor].CGColor;
    button1.layer.borderWidth = 0.5;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 1;
    [button1 setTitle:@"加载中" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton new];
    button2.layer.borderWidth = 0.5;
    button2.layer.borderColor = [UIColor blackColor].CGColor;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 2;
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 setTitle:@"其他" forState:UIControlStateNormal];
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton new];
    button3.layer.borderColor = [UIColor blackColor].CGColor;
    button3.layer.borderWidth = 0.5;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitle:@"改变模式" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    button3.translatesAutoresizingMaskIntoConstraints = NO;
    button3.tag = 3;
    [self.view addSubview:button3];
    
    NSMutableDictionary *viewsDic = [NSMutableDictionary new];
    viewsDic[@"button1"] = button1;
    viewsDic[@"button2"] = button2;
    viewsDic[@"button3"] = button3;
    
    NSMutableArray *stringsArray = [NSMutableArray new];
    [stringsArray addObject:@"H:|-20-[button1(100)]-50-[button2(==button1)]"];
    [stringsArray addObject:@"V:|-100-[button1(40)]-(-40)-[button2(==button1)]"];
    [stringsArray addObject:@"H:[button1]-0-[button3(150)]"];
    [stringsArray addObject:@"V:[button1]-20-[button3(==button1)]"];
    
    NSMutableArray *constraintsArray = [NSMutableArray new];
    for (NSString *str in stringsArray) {
        NSArray *arr = [NSLayoutConstraint constraintsWithVisualFormat:str options:0 metrics:nil views:viewsDic];
        [constraintsArray addObjectsFromArray:arr];
    }
    [self.view addConstraints:constraintsArray];
}

- (MBProgressHUD *)mbprogressHUD {
    if (!_mbprogressHUD) {
        _mbprogressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _mbprogressHUD;
}

- (void)buttonAction:(UIButton *)button {
    
    switch (button.tag) {
        case 1:
        {
            [self showHUD];
            
            break;
        }
        case 2:
        {
            
        }
            break;
        default:
        {
            _mode = arc4random() % 6;
            
            self.mbprogressHUD.mode = _mode;
            [self showHUD];
        }
            break;
    }
}

- (void)showHUD {
    if (self.mbprogressHUD) {
       [self.mbprogressHUD hideAnimated:YES]; 
    }
    
    [self.mbprogressHUD showAnimated:YES];
    [self.mbprogressHUD hideAnimated:YES afterDelay:1];
}

@end
