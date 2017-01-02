//
//  YTRegex.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "YTRegex.h"

@implementation YTRegex

+ (BOOL)isValidPhone:(NSString *)phoneText {
    
    NSString *regex = @"159\\d{8}|187\\d{8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [pred evaluateWithObject:phoneText];
    return isValid;
}

+ (BOOL)isValidEmail:(NSString *)emailText {
    //本规则：以字母开头，后面可跟0个或多个字母数字下划线
    NSString *regex = @"[a-zA-Z][0-9a-zA-Z_]*@[0-9a-zA-Z]{3}.[a-z]{3}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [pred evaluateWithObject:emailText];
    return isValid;
}

@end
