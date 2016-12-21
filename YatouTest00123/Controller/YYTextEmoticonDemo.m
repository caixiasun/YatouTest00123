//
//  YYTextEmoticonDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextEmoticonDemo.h"

@interface YYTextEmoticonDemo ()

@end

@implementation YYTextEmoticonDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@":smile:"] = [self imageWithName:@"002"];
    mapper[@":cool:"] = [self imageWithName:@"013"];
    mapper[@":biggrin:"] = [self imageWithName:@"047"];
    mapper[@":arrow:"] = [self imageWithName:@"007"];
    mapper[@":confused:"] = [self imageWithName:@"041"];
    mapper[@":cry:"] = [self imageWithName:@"010"];
    mapper[@":wink:"] = [self imageWithName:@"085"];
    
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = mapper;
    
    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
    modifier.fixedLineHeight = 22;
    
    YYTextView *textView = [YYTextView new];
    textView.text = @"Hahahah:smile:, it\'s emoticons::cool::arrow::cry::wink:\n\nYou can input \":\" + \"smile\" + \":\" to display smile emoticon, or you can copy and paste these emoticons.\n";
    textView.font = [UIFont systemFontOfSize:17];
    textView.textParser = parser;
    textView.size = self.view.size;
    textView.linePositionModifier = modifier;
    [self.view addSubview:textView];
    
}

- (UIImage *)imageWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
    NSString *path = [bundle pathForScaledResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    image.preloadAllAnimatedImageFrames = YES;
    return image;
}

@end
