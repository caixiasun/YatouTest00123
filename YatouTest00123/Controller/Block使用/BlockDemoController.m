//
//  BlockDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/17.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "BlockDemoController.h"
#import "YTBlock.h"

@interface BlockDemoController ()

@property (nonatomic, strong) YTBlock *block;

@end

@implementation BlockDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton new];
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 0.5;
    [button setTitle:@"我是一个按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    
    __block NSInteger testValue=  10;
    YTBlock *block = [YTBlock sharedInstance];
    self.block = block;
    block.voidBlock = ^ {
        testValue = 20;
        NSLog(@"_____voidblock 被调用了~~");
    };
    
}

- (void)buttonAction:(UIButton *)button {
    switch (button.tag) {
        case 0:
        {
            [self.block callVoidBlock];
            break;
        }
        case 1:{
            __weak typeof(self) weakSelf = self;
            self.block.changeBackColorBlock = ^(UIColor *color) {
                weakSelf.view.backgroundColor = color;
            };
            [self.block callChangeBackColorBlock];
            break;
        }
        default:
            break;
    }
}


@end
