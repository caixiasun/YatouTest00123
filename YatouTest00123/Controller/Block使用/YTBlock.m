//
//  YTBlock.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/17.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "YTBlock.h"

@interface YTBlock()

@property (nonatomic, strong) UIView *backView;

@end

@implementation YTBlock

+ (YTBlock *)sharedInstance {
    static YTBlock *block = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        block = [[YTBlock alloc] init];
    });
    return block;
}

- (void)callVoidBlock {
    if (self.voidBlock) {
        self.voidBlock();
    }
}

- (void)callChangeBackColorBlock {
    
    if (self.changeBackColorBlock) {
        self.changeBackColorBlock([self getRandomColor]);
    }
}

- (UIColor *)getRandomColor {
    UIColor *color;
    float r = arc4random() % 256;
    float g = arc4random() % 256;
    float b = arc4random() % 256;
    color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
    return color;
}

@end
