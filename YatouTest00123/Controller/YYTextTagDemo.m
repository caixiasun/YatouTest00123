//
//  YYTextTagDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextTagDemo.h"

@interface YYTextTagDemo ()<UIScrollViewDelegate>

@end

@implementation YYTextTagDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSArray *tags = @[@"◉red", @"◉orange", @"◉yellow", @"◉green", @"◉blue", @"◉purple", @"◉gray"];
    NSArray *tagStrokeColors = @[
                                 UIColorHex(fa3f39),
                                 UIColorHex(f48f25),
                                 UIColorHex(f1c02c),
                                 UIColorHex(54bc2e),
                                 UIColorHex(29a9ee),
                                 UIColorHex(c171d8),
                                 UIColorHex(818e91)
                                 ];
    NSArray *tagFillColors = @[
                               UIColorHex(fb6560),
                               UIColorHex(f6a550),
                               UIColorHex(f3cc56),
                               UIColorHex(76c957),
                               UIColorHex(53baf1),
                               UIColorHex(cd8ddf),
                               UIColorHex(a4a4a7)
                               ];
    
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    for (int i=0; i<tags.count; i++) {
        NSString *tag = tags[i];
        UIColor *strokeColor = tagStrokeColors[i];
        UIColor *fillColor = tagFillColors[i];
        NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:tag];
        [tagText insertString:@"   " atIndex:0];
        [tagText appendString:@"   "];
        tagText.font = font;
        tagText.color = [UIColor whiteColor];
        
        YYTextBorder *border = [YYTextBorder new];
        border.strokeWidth = 2;
        border.strokeColor = strokeColor;
        border.fillColor = fillColor;
        border.cornerRadius = 100;
        border.lineJoin = kCGLineJoinBevel;
        
        border.insets = UIEdgeInsetsMake(-2, -5.5, -2, -8);
        [tagText setTextBackgroundBorder:border range:[tagText.string rangeOfString:tag]];
        [text appendAttributedString:tagText];
    }
    text.lineSpacing = 10;
    text.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    YYTextView *textView = [YYTextView new];
    textView.size = self.view.size;
    textView.attributedText = text;
    textView.textContainerInset = UIEdgeInsetsMake(100, 10, 100, 10);
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview:textView];
    
}


@end
