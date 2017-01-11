//
//  BasicAnimationDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/11.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "BasicAnimationDemoController.h"

@interface BasicAnimationDemoController ()

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;

@end

@implementation BasicAnimationDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"1A1C26"];
    
    UIImageView *imgV1 = [UIImageView new];
    imgV1.image = [UIImage imageNamed:@"BasicAnimationDemo_ride_indoor_ring.png"];
    self.imageView1 = imgV1;
    [self.view addSubview:imgV1];
    [imgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.offset = 10;
        make.centerY.equalTo(self.view);
    }];
    
    UIImageView *imgV2 = [UIImageView new];
    imgV2.image = [UIImage imageNamed:@"BasicAnimationDemo_ride_outdoor_ring.png"];
    self.imageView2 = imgV2;
    [self.view addSubview:imgV2];
    [imgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(imgV1.mas_bottom);
    }];
    
    UIImageView *imgV3 = [UIImageView new];
    imgV3.image = [UIImage imageNamed:@"BasicAnimationDemo_ride_video_ring.png"];
    self.imageView3 = imgV3;
    [self.view addSubview:imgV3];
    [imgV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.offset = -10;
        make.centerY.equalTo(imgV1);
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"开始动画" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor cyanColor].CGColor;
    button.layer.borderWidth = 0.5;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgV2.mas_bottom);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

- (void)buttonAction {
//    CABasicAnimation 
}


@end
