//
//  MasonryCell.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/15.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "MasonryCell.h"

@interface MasonryCell ()

@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *titLab;

@end

@implementation MasonryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *imgV = [UIImageView new];
    imgV.backgroundColor = [UIColor redColor];
    [self addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(0.6);
        make.width.equalTo(self).multipliedBy(0.8);
        make.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    UILabel *titLab = [UILabel new];
    titLab.text = @"丫头测试";
    [self addSubview:titLab];
    self.titLab = titLab;
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = FitWidth(12);
        make.top.equalTo(imgV.mas_bottom).offset = FitHeight(20);
    }];
    
    UILabel *dateLab = [UILabel new];
    dateLab.text = @"2016-02-02 12:12";
    [self addSubview:dateLab];
    self.dateLab = dateLab;
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titLab);
        make.top.equalTo(titLab.mas_bottom);
    }];
}

- (void)setContent:(id)data {
    static int index = 0;
    index++;
    if (index % 2 == 0) {
        self.dateLab.hidden = YES;
        [self.titLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
        
    }
}

@end
