//
//  NSDate+YTDateCategory.h
//  YatouTest00123
//
//  Created by yatou on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YTDateCategory)

//计算这个月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth;

//确定这个月的第一天
- (NSDate *)firstDayOfCurrentMonth;
//确定这天星期几
- (NSUInteger)weeklyOrdinality;

//获得当前日期的年月日
- (int)getCurrentYear;
- (int)getCurrentMonth;
- (int)getCurrentDay;

@end
