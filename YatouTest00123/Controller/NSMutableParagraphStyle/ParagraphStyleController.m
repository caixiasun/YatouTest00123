//
//  ParagraphStyleController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/2.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ParagraphStyleController.h"

@interface ParagraphStyleController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ParagraphStyleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableParagraphStyle *mutableParagraphStyle = [NSMutableParagraphStyle new];
    mutableParagraphStyle.lineSpacing = 5;// 字体的行间距
    mutableParagraphStyle.firstLineHeadIndent = 20;//首行缩进
    mutableParagraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式
    mutableParagraphStyle.headIndent = 20;//整体缩进(首行除外)
    mutableParagraphStyle.hyphenationFactor = 0;
    
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont fontWithName : @"Zapfino"   size : 16.0],NSParagraphStyleAttributeName: mutableParagraphStyle};
    
    NSString *strDisplayText = @"This is an attributed string.我希望有个如你一般的人，如山间清爽的风，如古城温暖的光。从清晨到夜晚，由山野到书房。只要最后是你，就好。This is a NSMutableParagraphStyle's test String.";
    
    NSAttributedString *attributedText = [[ NSAttributedString alloc ] initWithString :strDisplayText attributes:attributes];
    self.label.attributedText = attributedText;
}


@end
