//
//  YYTextEditDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextEditDemo.h"

@interface YYTextEditDemo ()

@end

@implementation YYTextEditDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
    
    UIView *toolbar;
    if ([UIVisualEffectView class]) {
        toolbar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    } else {
        toolbar = [UIToolbar new];
    }
    toolbar.size = CGSizeMake(kScreenWidth, 40);
    toolbar.top = kiOS7Later ? 64 : 0;
    [self.view addSubview:toolbar];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the season of light, it was the season of darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us. We were all going direct to heaven, we were all going direct the other way.\n\n这是最好的时代，这是最坏的时代；这是智慧的时代，这是愚蠢的时代；这是信仰的时期，这是怀疑的时期；这是光明的季节，这是黑暗的季节；这是希望之春，这是失望之冬；人们面前有着各样事物，人们面前一无所有；人们正在直登天堂，人们正在直下地狱。"];
    text.font = [UIFont fontWithName:@"Times New Roman" size:20];
    text.lineSpacing = 4;
    text.firstLineHeadIndent = 20;
    
    YYTextView *textView = [YYTextView new];
    textView.attributedText = text;
    textView.size = self.view.size;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake(toolbar.bottom, 0, 0, 0);
    [self.view insertSubview:textView belowSubview:toolbar];
    
}

@end
