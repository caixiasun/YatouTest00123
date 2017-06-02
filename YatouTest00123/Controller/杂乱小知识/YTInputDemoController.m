//
//  YTInputDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/4/21.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "YTInputDemoController.h"

@interface YTInputDemoController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YTInputDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.7);
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length + string.length > 100) {
        return NO;
    }
    return YES;
}

- (void)textChange:(UITextField *)textField {
    
    static const int Max_Text_Length = 5;
    
    //获取当前键盘类型
    UITextInputMode *mode = (UITextInputMode *)[UITextInputMode activeInputModes][0];
     //获取当前键盘语言
    NSString *lang = mode.primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {//如果语言是汉语(拼音)
        //取到高亮部分范围
        UITextRange *selectedRange = [textField markedTextRange];
         //取到高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //如果取不到高亮部分,代表没有拼音
        if (!position){
            //当期超过最大限制时
            if (textField.text.length > Max_Text_Length) {
                //对超出部分进行裁剪
                textField.text = [textField.text substringToIndex:Max_Text_Length];
            }
        }
    }else {//如果语言不是汉语,直接计算
        if (textField.text.length > Max_Text_Length) {
            textField.text = [textField.text substringToIndex:Max_Text_Length];
        }
    }
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.placeholder = @"请输入内容：";
        _textField.borderStyle = UITextBorderStyleBezel;
        _textField.adjustsFontSizeToFitWidth = NO;
        [_textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:_textField];
    }
    return _textField;
}


@end
