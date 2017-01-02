//
//  RegexController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "RegexController.h"

@interface RegexController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@end

@implementation RegexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (IBAction)buttonAction:(UIButton *)item {
    if ([self isEmptyContent]) {
        self.promptLabel.text = @"请输入要验证的内容!!";
        return ;
    }
    switch (item.tag) {
        case 1://手机号
        {
            if ([YTRegex isValidPhone:self.textField.text]) {
                self.promptLabel.text = @"该手机号是合法的。";
            } else {
                self.promptLabel.text = @"该手机号无效！！";
            }
            break;
        }
        case 2://邮箱
        {
            if ([YTRegex isValidEmail:self.textField.text]) {
                self.promptLabel.text = @"该邮箱是合法的。";
            } else {
                self.promptLabel.text = @"该邮箱无效！！";
            }
            break;
        }
        default:
            break;
    }
}

- (BOOL)isEmptyContent {
    if (self.textField.text.length == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.promptLabel.text = @"";
    return YES;
}

- (void)setupUI {
    self.phoneBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.phoneBtn.layer.borderWidth = 0.5;
    self.phoneBtn.layer.masksToBounds = YES;
    self.phoneBtn.layer.cornerRadius = 5;
    
    self.emailBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.emailBtn.layer.borderWidth = 0.5;
    self.emailBtn.layer.masksToBounds = YES;
    self.emailBtn.layer.cornerRadius = 5;
}

@end
