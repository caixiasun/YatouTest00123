//
//  MasonryDemo01Controller.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/3/31.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "MasonryDemo01Controller.h"

@interface MasonryDemo01Controller ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *redView;
@property (nonatomic, strong) UIView       *greenView;
@property (nonatomic, strong) UIView       *yellowView;
@property (nonatomic, strong) UIView       *blueView;
@property (nonatomic, strong) UIView       *blackView;
@property (nonatomic, strong) UIButton     *testBtn;

@end

@implementation MasonryDemo01Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self appendConstraints];
}

- (void)itemAction:(UIButton *)item {
    
}

- (void)appendConstraints {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.top.offset = FitHeight(30);
        make.height.offset = FitHeight(100);
    }];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = FitWidth(300);
        make.height.offset = FitHeight(400);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.redView.mas_bottom).offset = FitHeight(100);
    }];
    
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.with.centerX.equalTo(self.redView);
        make.height.equalTo(self.greenView);
        make.top.equalTo(self.greenView.mas_bottom).offset = FitHeight(150);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.centerX.equalTo(self.redView);
        make.top.equalTo(self.yellowView.mas_bottom).offset = FitHeight(100);
    }];
    
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.and.centerX.equalTo(self.blueView);
        make.top.equalTo(self.blueView.mas_bottom).offset = FitHeight(30);
    }];
    
    [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = FitHeight(100);
        make.left.offset = FitWidth(110);
        make.right.equalTo(self.view).offset = -FitWidth(110);
        make.top.equalTo(self.blackView.mas_bottom).offset = FitHeight(120);
    }];
    
    [self updateScrollViewContentSize];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [UIView new];
        _redView.backgroundColor = RedColor;
        [self.scrollView addSubview:_redView];
    }
    return _redView;
}

- (UIView *)greenView {
    if (!_greenView) {
        _greenView = [UIView new];
        _greenView.backgroundColor = GreenColor;
        [self.scrollView addSubview:_greenView];
    }
    return _greenView;
}

- (UIView *)yellowView {
    if (!_yellowView) {
        _yellowView = [UIView new];
        _yellowView.backgroundColor = YellowColor;
        [self.scrollView addSubview:_yellowView];
    }
    return _yellowView;
}

- (UIView *)blueView {
    if (!_blueView) {
        _blueView = [UIView new];
        _blueView.backgroundColor = BlueColor;
        [self.scrollView addSubview:_blueView];
    }
    return _blueView;
}

- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [UIView new];
        _blackView.backgroundColor = BlackColor;
        [self.scrollView addSubview:_blackView];
    }
    return _blackView;
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton new];
        [_testBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
        [_testBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _testBtn.backgroundColor = BlackColor;
        [_testBtn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_testBtn];
    }
    return _testBtn;
}

- (void)updateScrollViewContentSize {
    [self.view layoutIfNeeded];
    [self.scrollView setContentSize:CGSizeMake(Screen_Width, self.testBtn.bottom + FitHeight(100))];
}

@end
