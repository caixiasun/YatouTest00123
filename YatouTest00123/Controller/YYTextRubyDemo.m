//
//  YYTextRubyDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextRubyDemo.h"

@interface YYTextRubyDemo ()

@end

@implementation YYTextRubyDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"这是用汉语写下的一段文字"];
        one.font = [UIFont systemFontOfSize:30];
        
        YYTextRubyAnnotation *ruby = [YYTextRubyAnnotation new];
        ruby.textBefore = @"hàn yŭ";
        ruby.textInterCharacter = @"Inter";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"汉语"]];
        
        ruby = [YYTextRubyAnnotation new];
        ruby.textAfter = @"wén";
        ruby.textInline = @"Inline";
        [one setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"文"]];
        
        [text appendAttributedString:one];
    }
    
    YYLabel *myLabel = [YYLabel new];
    myLabel.attributedText = text;
    myLabel.size = self.view.size;
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    myLabel.numberOfLines = 0;
    myLabel.backgroundColor = [UIColor colorWithRed:0.5 green:0.3 blue:0.4 alpha:1];
    [self.view addSubview:myLabel];
}

@end
