//
//  ChineseCharactersSortedController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/6.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ChineseCharactersSortedController.h"
#import "YTCharacterConvertTool.h"

@interface ChineseCharactersSortedController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ChineseCharactersSortedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *chineseArray = @[@"周杰伦",@"王菲",@"a制作",@"庄心妍",@"金贵晟"];
    NSArray *sortArray = [YTCharacterConvertTool sortedChineseCharacter:chineseArray];
    for (YTCharacterConvertObj *obj in sortArray) {
        NSLog(@"_______%@______%@",obj.chinese,obj.pinyin);
    }
}

@end
