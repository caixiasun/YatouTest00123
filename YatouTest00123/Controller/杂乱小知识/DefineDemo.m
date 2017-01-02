//
//  DefineDemo.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "DefineDemo.h"

#define Num1 2+3
#define Num2 (2+3)

@interface DefineDemo ()

@end

@implementation DefineDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"__%d",3*Num1);//9
    NSLog(@"__%d",3*Num2);//15
}

@end
