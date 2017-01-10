//
//  RuntimeDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/9.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "RuntimeClass.h"

@interface RuntimeClass()<NSCopying>

@property (nonatomic, strong) UILabel *privateLabel;

@end

@implementation RuntimeClass

- (void)run {
    
}
- (void)eat:(NSString *)eat {
    NSLog(@"你吃了一个苹果");
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSString *name = NSStringFromSelector(sel);
    if ([name isEqualToString:@"myTest"]) {
        NSLog(@"这个方法不存在哦，改一下吧~~");
        return NO;
    }
    return YES;
}

- (void)myTest {
    NSLog(@"__RuntimeClass 类的myTest方法被调用了...");
}

@end
