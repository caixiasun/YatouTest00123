//
//  YYTextAttributeDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextAttributeDemo.h"

@interface YYTextAttributeDemo ()

@end

@implementation YYTextAttributeDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Shadow"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor redColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor redColor];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Inner Shadow"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor greenColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor redColor];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 1;
        one.textShadow = shadow;
        
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Multi Shadow"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor purpleColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor redColor];
        shadow.offset = CGSizeMake(0, -1);
        shadow.radius = 1.5;
        YYTextShadow *subShadow = [YYTextShadow new];
        subShadow.color = [UIColor yellowColor];
        subShadow.offset = CGSizeMake(0, 1);
        subShadow.radius = 1.5;
        shadow.subShadow = subShadow;
        YYTextShadow *sub2Shadow = [YYTextShadow new];
        sub2Shadow.color = [UIColor blueColor];
        sub2Shadow.offset = CGSizeMake(2, 3);
        sub2Shadow.radius = 1.5;
        subShadow.subShadow = sub2Shadow;
        one.textShadow = shadow;
        
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Background Image"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor purpleColor];
        CGSize size = CGSizeMake(20, 20);
        UIImage *background = [UIImage imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
            UIColor *c0 = [UIColor greenColor];
            UIColor *c1 = [UIColor redColor];
            [c0 setFill];
            CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
            [c1 setStroke];
            CGContextSetLineWidth(context, 2);
            for (int i=0; i<size.width*2; i+= 4) {
                CGContextMoveToPoint(context, i, -2);
                CGContextAddLineToPoint(context, i-size.height, size.height+2);
            }
            CGContextStrokePath(context);
        }];
        one.color = [UIColor colorWithPatternImage:background];
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Border"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        
        YYTextBorder *border = [YYTextBorder new];
        border.strokeColor = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        border.strokeWidth = 3;
        border.lineStyle = YYTextLineStylePatternDashDotDot;
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(0, -8, 0, -4);
        one.textBackgroundBorder = border;
        
        [attributedString appendAttributedString:[self padding]];
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
        [attributedString appendAttributedString:[self padding]];
        [attributedString appendAttributedString:[self padding]];
        [attributedString appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.underlineStyle = NSUnderlineStyleThick;
        one.color = [UIColor redColor];
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(-2, -1, -2, -1);
        border.fillColor = [UIColor yellowColor];
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setBorder:border];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSLog(@"Link label clicked.....");
        };
        [one setTextHighlight:highlight range:one.rangeOfAll];
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor redColor];
        
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 50;
        border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        border.strokeWidth = 0.5;
        border.strokeColor = one.color;
        border.lineStyle = YYTextLineStyleSingle;
        one.textBackgroundBorder = border;
        
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = one.color;
        highlightBorder.fillColor = one.color;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        [highlight setBackgroundBorder:highlightBorder];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSLog(@"Link label clicked.....");
        };
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [attributedString appendAttributedString:one];
        [attributedString appendAttributedString:[self padding]];
    }
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
        one.font = [UIFont boldSystemFontOfSize:30];
        one.color = [UIColor whiteColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.textShadow = shadow;
        
        YYTextShadow *shadow0 = [YYTextShadow new];
        shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow0.offset = CGSizeMake(0, -1);
        shadow0.radius = 1.5;
        YYTextShadow *shadow1 = [YYTextShadow new];
        shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
        shadow1.offset = CGSizeMake(0, 1);
        shadow1.radius = 1.5;
        shadow0.subShadow = shadow1;
        
        YYTextShadow *innerShadow0 = [YYTextShadow new];
        innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow0.offset = CGSizeMake(0, 1);
        innerShadow0.radius = 1;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        [highlight setShadow:shadow0];
        [highlight setInnerShadow:innerShadow0];
        [one setTextHighlight:highlight range:one.rangeOfAll];
        
        [attributedString appendAttributedString:one];
    }
    
    YYLabel *label = [YYLabel new];
    label.size = CGSizeMake(self.view.width, self.view.height-64);
    label.attributedText = attributedString;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}


@end
