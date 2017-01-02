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
    
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont fontWithName : @"Zapfino"   size : 16.0]};
    
    NSString *strDisplayText = @"This is an attributed string.";
    
    NSAttributedString *attributedText = [[ NSAttributedString alloc ] initWithString :strDisplayText attributes:attributes];
    self.label.attributedText = attributedText;
}


@end
