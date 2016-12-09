//
//  OtherTestView.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "OtherTestView.h"
#import <Masonry.h>

@implementation OtherTestView
- (void)createOtherTestViewInView:(UIView *)inView {
    OtherTestView *customV = [OtherTestView new];
    [inView addSubview:customV];
    [customV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(inView.mas_height).multipliedBy(0.5);
        make.center.equalTo(inView);
    }];
    
    customV.layer.borderWidth = 2;
    customV.layer.borderColor = [UIColor redColor].CGColor;
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
    [customV addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.right.offset = -20;
        make.top.offset = 20;
        make.bottom.offset = -20;
//        make.center.equalTo(customV);
    }];
    
    imgV.layer.cornerRadius = imgV.frame.size.height*0.5;
    imgV.layer.masksToBounds = YES;
    imgV.layer.borderColor = [UIColor greenColor].CGColor;
    imgV.layer.borderWidth = 1;
    
}

@end
