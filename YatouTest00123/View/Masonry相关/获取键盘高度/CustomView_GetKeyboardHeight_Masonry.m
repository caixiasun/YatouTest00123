//
//  CustomView_GetKeyboardHeight_Masonry.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "CustomView_GetKeyboardHeight_Masonry.h"
#import <Masonry.h>

@implementation CustomView_GetKeyboardHeight_Masonry

+ (CustomView_GetKeyboardHeight_Masonry *)createViewInView:(UIView *)inView Delegate:(id)delegate {
    CustomView_GetKeyboardHeight_Masonry *customV = [CustomView_GetKeyboardHeight_Masonry new];
    customV.delegate = delegate;
    [inView addSubview:customV];
    [customV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(inView);
        make.center.equalTo(inView);
    }];
    customV.backgroundColor = [UIColor redColor];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor greenColor];
    [customV addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = 100;
        make.height.offset = 40;
        make.center.equalTo(customV);
    }];
    
    UILabel *lab = [UILabel new];
    lab.font = [UIFont systemFontOfSize:20];
    lab.text = @"测试一下啦~~";
    lab.textColor = [UIColor purpleColor];
    lab.backgroundColor = [UIColor whiteColor];
    [customV addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(customV);
        make.left.offset = 20;
    }];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"playroom_close.png"] forState:UIControlStateNormal];
    [exitBtn addTarget:customV action:@selector(itemAction) forControlEvents:UIControlEventTouchUpInside];
    [customV addSubview:exitBtn];
    [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.offset = 25;
        make.top.offset = 15;
        make.right.offset = -15;
    }];
    
    return customV;
}

- (void)itemAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(close)]) {
        [self.delegate close];
    }
}

@end
