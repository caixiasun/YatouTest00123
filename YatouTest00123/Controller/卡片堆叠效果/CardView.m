//
//  CardView.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/3.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "CardView.h"

#define CardView_Width kScreenWidth
#define CardView_Height kScreenHeight*0.8

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.size = CGSizeMake(CardView_Width, CardView_Height);
        self.backgroundColor = [self randomColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (UIColor *)randomColor {
    CGFloat r = (arc4random()%256 + 1)/255.0;
    CGFloat g = (arc4random()%256 + 1)/255.0;
    CGFloat b = (arc4random()%256 + 1)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
