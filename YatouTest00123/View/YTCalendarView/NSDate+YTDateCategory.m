//
//  NSDate+YTDateCategory.m
//  YatouTest00123
//
//  Created by yatou on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "NSDate+YTDateCategory.h"

@implementation NSDate (YTDateCategory)

//计算这个月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth {
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

//确定这个月的第一天
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}
//确定这天星期几
- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:self]-1;
}

//获得当前日期的年月日
- (int)getCurrentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:flags fromDate:self];
    return (int)components.year;
    
}
- (int)getCurrentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:flags fromDate:self];
    return (int)components.month;
}
- (int)getCurrentDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:flags fromDate:self];
    return (int)components.day;
}

@end
