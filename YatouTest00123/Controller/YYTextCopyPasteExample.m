//
//  YYTextCopyPasteExample.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextCopyPasteExample.h"

@interface YYTextCopyPasteExample ()

@end

@implementation YYTextCopyPasteExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    NSString *text = @"You can copy image from browser or photo album and paste it to here. It support animated GIF and APNG. \n\nYou can also copy attributed string from other YYTextView.\n";
    
    YYTextSimpleMarkdownParser *parser = [YYTextSimpleMarkdownParser new];
    [parser setColorWithDarkTheme];
    
    YYTextView *textView = [YYTextView new];
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:17];
    textView.size = self.view.size;
    textView.allowsPasteImage = YES; /// Pasts image
    textView.allowsPasteAttributedString = YES; /// Paste attributed string
    if (kiOS7Later) {
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    [self.view addSubview:textView];
    
}

@end
