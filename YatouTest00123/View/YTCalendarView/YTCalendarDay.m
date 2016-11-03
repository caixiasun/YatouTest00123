//
//  YTCalendarDay.m
//  YatouTest00123
//
//  Created by yatou on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTCalendarDay.h"

@interface YTCalendarDay()
{
    UIButton *_dayBtn;
}

@end

@implementation YTCalendarDay

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = .3;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [btn setTitleColor:YTCalendarDay_TextColor_Normal forState:UIControlStateNormal];
        _dayBtn = btn;
        [self addSubview:btn];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [btn addGestureRecognizer:tap];
    }
    return self;
}

-(void)setNumber:(int)number {
    self.tag = number;
    if (number == 0) {
        [_dayBtn setTitle:@"" forState:UIControlStateNormal];
        return;
    }
    [_dayBtn setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
}

- (void)setDayStatus:(NSInteger)status {
    if (status == YTCalendarDayStatusNormal) {
        self.backgroundColor = YTCalendarDay_BackgroundColor_Normal;
        [_dayBtn setTitleColor:YTCalendarDay_TextColor_Normal forState:UIControlStateNormal];
    }else if (status == YTCalendarDayStatusSelect){
        self.backgroundColor = YTCalendarDay_BackgroundColor_Select;
        [_dayBtn setTitleColor:YTCalendarDay_TextColor_Select forState:UIControlStateNormal];
    }else {
        self.backgroundColor = YTCalendarDay_BackgroundColor_Current;
        [_dayBtn setTitleColor:YTCalendarDay_TextColor_Select forState:UIControlStateNormal];        
    }
}

- (void)tapAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapDayItem:)]) {
        [self.delegate tapDayItem:self];
    }
}

@end
