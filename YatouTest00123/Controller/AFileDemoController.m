//
//  AFileDemoController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/6.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "AFileDemoController.h"
#import "TestAFile.h"

@interface AFileDemoController ()

@end

@implementation AFileDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestAFile *testA = [TestAFile new];
    NSInteger testNum = [testA sumWithFirstNum:1 SecondNum:2];
    NSLog(@"___%ld",testNum);
}

@end
