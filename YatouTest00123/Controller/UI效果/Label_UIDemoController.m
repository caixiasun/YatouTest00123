//
//  Label_UIDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/1.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "Label_UIDemoController.h"
#import <Masonry.h>

@interface Label_UIDemoController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation Label_UIDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI {
    UIScrollView *scroll = [UIScrollView new];
    [self.view addSubview:scroll];
    self.scrollView = scroll;
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    //Label 阴影效果
    UILabel *shadowLabel = [UILabel new];
    shadowLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    shadowLabel.text = @"Hello World";
    //阴影
    shadowLabel.shadowColor = [UIColor greenColor];
    shadowLabel.shadowOffset = CGSizeMake(0, 3);
    shadowLabel.layer.shadowRadius = 5;
    shadowLabel.layer.shadowOpacity = 0.6;
    shadowLabel.layer.shadowColor = [UIColor redColor].CGColor;
    shadowLabel.transform = CGAffineTransformMakeRotation(0.1);
    [self.scrollView addSubview:shadowLabel];
    [shadowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.offset = 10;
    }];
}

@end
