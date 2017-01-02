//
//  YYTextSimpleMarkdownParserDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextSimpleMarkdownParserDemo.h"

@interface YYTextSimpleMarkdownParserDemo ()

@end

@implementation YYTextSimpleMarkdownParserDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *text = @"#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n";
    
    YYTextSimpleMarkdownParser *parser = [YYTextSimpleMarkdownParser new];
    [parser setColorWithDarkTheme];
    
    YYTextView *textView = [YYTextView new];
    textView.size = self.view.size;
    textView.textParser = parser;
    textView.text = text;
    textView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:textView];
}

@end
