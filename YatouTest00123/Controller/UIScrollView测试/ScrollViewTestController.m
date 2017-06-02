//
//  ScrollViewTestController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/3/6.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "ScrollViewTestController.h"

@interface ScrollViewTestController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ScrollViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(275, 300));
        make.centerX.equalTo(self.view);
        make.top.offset = 50;
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset = 20;
        make.width.centerX.equalTo(self.view);
        make.height.offset = 30;
    }];
    
    
    //评分测试
    [self testMethod];
}

- (void)testMethod {
    UIView *starView = [UIView new];
    starView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:starView];
    
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 30;
        make.centerX.equalTo(self.view);
        make.width.offset = 300;
        make.top.equalTo(self.pageControl.mas_bottom).offset = 50;
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor greenColor];
    [starView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(starView);
        make.width.offset = 1;
        make.center.equalTo(starView);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor greenColor];
    [starView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(starView);
        make.width.offset = 1;
        make.centerY.equalTo(starView);
        make.centerX.equalTo(starView).multipliedBy(0.66);
    }];
    
    UIView *line0 = [UIView new];
    line0.backgroundColor = [UIColor greenColor];
    [starView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(starView);
        make.width.offset = 1;
        make.centerY.equalTo(starView);
        make.centerX.equalTo(starView).multipliedBy(0.33);
    }];
    
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = [UIColor greenColor];
    [starView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(starView);
        make.width.offset = 1;
        make.centerY.equalTo(starView);
        make.centerX.equalTo(starView).multipliedBy(1.33);
    }];
    
    UIView *line4 = [UIView new];
    line4.backgroundColor = [UIColor greenColor];
    [starView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(starView);
        make.width.offset = 1;
        make.centerY.equalTo(starView);
        make.centerX.equalTo(starView).multipliedBy(1.66);
    }];
    
    for (int i=0; i<5; i++) {
        UIImageView *img = [UIImageView new];
        img.backgroundColor = [UIColor redColor];
        [starView addSubview:img];
        CGFloat centerY;
        if (i == 0) {
            centerY = 0.33+0;
        }else {
            centerY = 0.33+i*0.33;
        }
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 20;
            make.width.equalTo(img.mas_height);
            make.centerY.equalTo(starView);
            make.centerX.equalTo(starView).multipliedBy(centerY);
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / 275.0;
    self.pageControl.currentPage = page;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        [self.view addSubview:_scrollView];
        
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [UIImageView new];
            img.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            img.frame = CGRectMake(i*275, 0, 275, 300);
            [_scrollView addSubview:img];
        }
        [_scrollView setContentSize:CGSizeMake(5*275, 300)];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.numberOfPages = 5;
        _pageControl.currentPage = 0;
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}


@end
