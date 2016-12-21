//
//  YYTextBindDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextBindDemo.h"
@interface YYTextExampleEmailBindingParser:NSObject <YYTextParser>

@property (nonatomic, strong) NSRegularExpression *regex;

@end
@implementation YYTextExampleEmailBindingParser

- (instancetype)init {
    self = [super init];
    NSString *pattern = @"[-_a-zA-Z@\\.]+[ ,\\n]";
    self.regex = [[NSRegularExpression alloc] initWithPattern:pattern options:kNilOptions error:nil];
    return self;
}

- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)selectedRange {
    __block BOOL changed = NO;
    [_regex enumerateMatchesInString:text.string options:NSMatchingWithoutAnchoringBounds range:text.rangeOfAll usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (!result) return;
        NSRange range = result.range;
        if (range.location == NSNotFound || range.length < 1) return;
        if ([text attribute:YYTextBindingAttributeName atIndex:range.location effectiveRange:NULL]) return;
        
        NSRange bindlingRange = NSMakeRange(range.location, range.length - 1);
        YYTextBinding *binding = [YYTextBinding bindingWithDeleteConfirm:YES];
        [text setTextBinding:binding range:bindlingRange]; /// Text binding
        [text setColor:[UIColor colorWithRed:0.000 green:0.519 blue:1.000 alpha:1.000] range:bindlingRange];
        changed = YES;
    }];
    return changed;
}

@end

@interface YYTextBindDemo ()

@end

@implementation YYTextBindDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"sjobs@apple.com, apple@apple.com, banana@banana.com, pear@pear.com,123#456 "];
    text.font = [UIFont systemFontOfSize:17];
    text.lineSpacing = 5;
    text.color = [UIColor blackColor];
    
    YYTextView *textView = [YYTextView new];
    textView.attributedText = text;
    textView.textParser = [YYTextExampleEmailBindingParser new];
    textView.size = self.view.size;
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    [self.view addSubview:textView];
}

@end
