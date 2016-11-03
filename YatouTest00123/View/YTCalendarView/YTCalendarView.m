//
//  YTCalendarView.m
//
//
//  Created by yatou on 16/10/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTCalendarView.h"

#define YTCalendarView_BackgroundColor [UIColor whiteColor]
#define YTCalendarView_width CGRectGetWidth(self.frame)
#define YTTextGrayColor [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1]
#define YTCalendarView_lineColor [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1]
#define YTCalendarView_DisplayYear_Height 20 //年份显示view高度
#define YTCalendarView_Margin 10//上下控件间隔

@interface YTCalendarView()<YTCalendarDayDelegate>
{
    CGFloat        _currentY;//记录当前Y位置
    UILabel        *_yearLab;//显示年份
    int            _firstDayOfWeek;//记录本月第一天是周几
    int            _currentYear;//当前年份
    int            _currentMonth;//当前月份
    int            _currentDay;//当前日
    int            _displayYear;//当前显示的年份
    int            _displayMonth;//当前显示的月份
    int            _displayDay;//当前显示的日
    YTCalendarDay  *_preSelectDay;//上次点击的day
    int            _selectYear;//当前显示的年份
    int            _selectMonth;//当前显示的月份
    int            _selectDay;//当前选中的日
    
}

@property (nonatomic, strong) NSMutableArray *dayItemsArray;

@end

@implementation YTCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self=  [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YTCalendarView_BackgroundColor;
        
        [self initUI];
        
        [self initDate];
        
        [self initDayUI];
        
        [self calculateDaysInCurrentMonthWithDate:[self getCurrentDate]];
    }
    return self;
}

- (void)initUI {
    //顶部
    [self initTopUI];
    
    //周
    [self initWeekUI];
}

- (void)initTopUI {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, YTCalendarView_Margin, YTCalendarView_width, YTCalendarView_DisplayYear_Height)];
    [self addSubview:topView];
    UILabel *yearLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YTCalendarView_width*0.5, CGRectGetHeight(topView.frame))];
    yearLab.text = @"0000年00月";
    yearLab.textColor = [UIColor blueColor];
    yearLab.textAlignment = NSTextAlignmentCenter;
    yearLab.center = CGPointMake(CGRectGetWidth(topView.frame)*0.5, yearLab.center.y);
    _yearLab = yearLab;
    [topView addSubview:yearLab];
    
    UIImageView *forwardImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_forward.png"]];
    forwardImg.frame = CGRectMake(24, 0, 10, 18);
    forwardImg.center = CGPointMake(forwardImg.center.x, yearLab.center.y);
    [topView addSubview:forwardImg];
    
    UIView *forV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTCalendarView_width*0.2, CGRectGetHeight(topView.frame))];
    forV.tag = 1;
    forV.backgroundColor = [UIColor clearColor];
    [topView addSubview:forV];
    UITapGestureRecognizer *forTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMonthTapAction:)];
    [forV addGestureRecognizer:forTap];
    
    UIImageView *backwardImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar_backward.png"]];
    backwardImg.frame = CGRectMake(CGRectGetWidth(topView.frame)-42, 0, 10, 18);
    backwardImg.center = CGPointMake(backwardImg.center.x, yearLab.center.y);
    [topView addSubview:backwardImg];
    
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(YTCalendarView_width-YTCalendarView_width*0.2, 0, YTCalendarView_width*0.2, CGRectGetHeight(topView.frame))];
    backV.tag = 2;
    backV.backgroundColor = [UIColor clearColor];
    [topView addSubview:backV];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMonthTapAction:)];
    [backV addGestureRecognizer:backTap];
    
    _currentY = YTCalendarView_Margin+YTCalendarView_DisplayYear_Height;
}

- (void)initWeekUI {
    UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(0, _currentY+YTCalendarView_Margin, YTCalendarView_width, YTCalendarView_DisplayYear_Height)];
    [self addSubview:weekView];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 35, YTCalendarView_width, 0.5);
    line.backgroundColor = YTCalendarView_lineColor;
    [self addSubview:line];
    
    CGFloat width = CGRectGetWidth(weekView.frame)/7;
    CGFloat height = CGRectGetHeight(weekView.frame);
    NSArray *weekArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i=0; i<7; i++) {
        UILabel *lab = [UILabel new];
        lab.frame = CGRectMake(i*width, 0, width, height);
        lab.text = weekArr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = YTTextGrayColor;
        lab.font = [UIFont systemFontOfSize:15];
        [weekView addSubview:lab];
        if (i==0 || i==6) {
            lab.textColor = [UIColor redColor];
        }
    }
    _currentY = _currentY+YTCalendarView_Margin+YTCalendarView_DisplayYear_Height+5;
}

- (void)initDayUI {
    UIView *dayView = [[UIView alloc] initWithFrame:CGRectMake(0, _currentY, YTCalendarView_width, YTCalendarView_Height-_currentY)];
    [self addSubview:dayView];
    NSInteger count = 42;
    NSInteger row = 6;
    NSInteger column = 7;
    CGFloat width = YTCalendarView_width/column;
    CGFloat height = CGRectGetHeight(dayView.frame)/row;
    self.dayItemsArray = [NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++) {
        
        YTCalendarDay *calendarDay = [[YTCalendarDay alloc] initWithFrame:CGRectMake((i%column)*width, (i/column)*height, width, height)];
        calendarDay.delegate = self;
        calendarDay.tag = i+1;
        [dayView addSubview:calendarDay];
        [self.dayItemsArray addObject:calendarDay];
    }
}

- (void)initDate {
    NSDate *currentDate = [self getCurrentDate];
    _currentYear = _displayYear = [currentDate getCurrentYear];
    _currentMonth = _displayMonth = [currentDate getCurrentMonth];
    _currentDay = _displayDay = [currentDate getCurrentDay];
}

- (void)calculateDaysInForwardMonth {
    if (_displayMonth == 1) {
        _displayYear -= 1;
        _displayMonth = 12;
        
    }else {
        _displayMonth -= 1;
    }
    _displayDay = 1;
    
    [self calculateDaysInCurrentMonthWithDate:[self createDisplayDate]];
}

- (void)calculateDaysInBackwardMonth {
    if (_displayMonth == 12) {
        _displayMonth = 1;
        _displayYear += 1;
    }else {
        _displayMonth += 1;
    }
    _displayDay = 1;
    
    [self calculateDaysInCurrentMonthWithDate:[self createDisplayDate]];
}
//根据年月日创建日期
- (NSDate *)createDisplayDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger flags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *components = [calendar components:flags fromDate:[NSDate new]];
    [components setYear:_displayYear];
    [components setMonth:_displayMonth];
    [components setDay:_displayDay];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

//获取本月的 日历
- (void)calculateDaysInCurrentMonthWithDate:(NSDate *)date {
    _yearLab.text = [NSString stringWithFormat:@"%d年%d月",_displayYear,_displayMonth];
    
    [self.dayItemsArray enumerateObjectsUsingBlock:^(YTCalendarDay *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.number = 0;
        obj.isAvailable = NO;
    }];
    
    NSUInteger daysCount = [date numberOfDaysInCurrentMonth];
    NSUInteger firstDay = [[date firstDayOfCurrentMonth] weeklyOrdinality];
    for (int i = 0; i<daysCount; i++) {
        NSInteger num = i + firstDay;
        YTCalendarDay *day = [self.dayItemsArray objectAtIndex:num];
        day.number = i+1;
        day.isAvailable = YES;
        if (i+1 == _currentDay && _currentYear == _displayYear && _currentMonth == _displayMonth) {
            [day setDayStatus:YTCalendarDayStatusCurrent];
        }else if (day == _preSelectDay && _selectYear == _displayYear && _selectMonth == _displayMonth){
            [day setDayStatus:YTCalendarDayStatusSelect];
        }else {
            [day setDayStatus:YTCalendarDayStatusNormal];
        }
    }
}

//当前日期
- (NSDate *)getCurrentDate {
    return [NSDate date];
}

#pragma mark - action method
//月份切换
- (void)changeMonthTapAction:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.view.tag == 1) {//向前
        [self calculateDaysInForwardMonth];
    }else {//向后
        [self calculateDaysInBackwardMonth];
    }
}


#pragma mark - YTCalendarDayDelegate
- (void)tapDayItem:(YTCalendarDay *)day {
    if (day.isAvailable) {
        [_preSelectDay setDayStatus:YTCalendarDayStatusNormal];
        if (day.tag == _currentDay && _currentYear == _displayYear && _currentMonth == _displayMonth) {
            _preSelectDay = nil;
        }else {
            [day setDayStatus:YTCalendarDayStatusSelect];
            _preSelectDay = day;
            _selectYear = _displayYear;
            _selectMonth = _displayMonth;
            _selectDay = _displayDay;
        }
    }
}

@end
