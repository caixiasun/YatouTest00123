//
//  YTRegex.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTRegex : NSObject


/**
 验证手机号码是否有效
 @param phoneText 验证字符串
 */
+ (BOOL)isValidPhone:(NSString *)phoneText;

/**
 验证邮箱是否有效
 @param emailText 验证字符串
 */
+ (BOOL)isValidEmail:(NSString *)emailText;

@end
