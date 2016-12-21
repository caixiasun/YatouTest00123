//
//  PictureMachine_AnimationController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//  图像处理

#import "PictureMachine_AnimationController.h"
#import "UIImage+PictureMachine.h"

@interface PictureMachine_AnimationController ()

@end

@implementation PictureMachine_AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    UIColor *originColor = [UIColor whiteColor];
    UIColor *destiColor = [UIColor redColor];
    
    //改变图片本身的颜色
    UIImageView *image1 = [UIImageView new];
    image1.image = [UIImage imageNamed:@"picturMachine_edit.png"];
    [self.view addSubview:image1];
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.offset = 10;
        make.centerY.equalTo(self.view);
    }];
    UILabel *lab1 = [UILabel new];
    lab1.text = @"原图";
    lab1.textColor = originColor;
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(image1);
        make.bottom.equalTo(image1.mas_top).offset = -5;
    }];
    
    UIImageView *image2 = [UIImageView new];
    image2.image = [image1.image imageWithTintColor:destiColor];
    [self.view addSubview:image2];
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(image1);
        make.right.offset = -30;
        make.centerY.equalTo(self.view);
    }];
    UILabel *lab2 = [UILabel new];
    lab2.text = @"渲染后的图片";
    lab2.textColor = destiColor;
    [self.view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(image2);
        make.bottom.equalTo(image2.mas_top).offset = -5;
    }];
}



@end
