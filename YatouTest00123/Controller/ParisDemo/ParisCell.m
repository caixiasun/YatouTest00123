//
//  ParisCell.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/6.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ParisCell.h"

@implementation ParisCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
