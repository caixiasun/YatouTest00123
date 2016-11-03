//
//  YTCalendarDay.h
//  YatouTest00123
//
//  Created by yatou on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>

enum YTCalendarDayStatus{
    YTCalendarDayStatusNormal = 1,
    YTCalendarDayStatusSelect = 2,
    YTCalendarDayStatusCurrent = 3
};

#define YTCalendarViewRGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define YTCalendarDay_TextColor_Normal YTCalendarViewRGBColor(195, 195, 195)
#define YTCalendarDay_TextColor_Select YTCalendarViewRGBColor(69, 189, 210)
#define YTCalendarDay_BackgroundColor_Select YTCalendarViewRGBColor(255, 189, 210)
#define YTCalendarDay_BackgroundColor_Normal [UIColor clearColor]
#define YTCalendarDay_BackgroundColor_Current YTCalendarViewRGBColor(153, 20, 139)//当前日期背景色

@protocol YTCalendarDayDelegate;

@interface YTCalendarDay : UIView

@property (nonatomic, assign) id<YTCalendarDayDelegate>delegate;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) BOOL isAvailable;//是否可用

- (void)setDayStatus:(NSInteger)status;

@end

@protocol YTCalendarDayDelegate <NSObject>

- (void)tapDayItem:(YTCalendarDay *)day;

@end


