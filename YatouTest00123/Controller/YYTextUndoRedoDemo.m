//
//  YYTextUndoRedoDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YYTextUndoRedoDemo.h"

@interface YYTextUndoRedoDemo ()

@end

@implementation YYTextUndoRedoDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *text = @"You cna shake the device to undo and redo .";
    
    YYTextView *textView = [YYTextView new];
    textView.size = self.view.size;
    textView.text = text;
    textView.font = [UIFont systemFontOfSize:17];
    textView.allowsUndoAndRedo = YES;
    textView.maximumUndoLevel = 3;
    [self.view addSubview:textView];
}

@end
