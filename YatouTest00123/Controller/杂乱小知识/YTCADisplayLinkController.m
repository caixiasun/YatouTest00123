//
//  YTCADisplayLinkController.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/4/21.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "YTCADisplayLinkController.h"

@interface YTCADisplayLinkController ()
{
    int _linkNumber;
}

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSMutableArray *linkDataSource;
@property (nonatomic, strong) UIImageView *linkImgView;

@end

@implementation YTCADisplayLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self cadisplaylinkTest];
}

//CADisplayLink测试
- (void)cadisplaylinkTest {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 200, 50);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(linkAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.linkDataSource = [NSMutableArray new];
    for (int i=0; i<100; i++) {
        [self.linkDataSource addObject:[NSString stringWithFormat:@"balloon%d.png",i]];
    }
    
    UIImageView *imgV = [UIImageView new];
    imgV.frame = self.view.bounds;
    imgV.center = self.view.center;
    [self.view addSubview:imgV];
    self.linkImgView = imgV;
    
}

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkUpdate)];
        _link.paused = YES;
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _linkNumber = 0;
    }
    return _link;
}

- (void)linkAction {
    self.link.paused = NO;
}

- (void)linkUpdate {
    
    if (_linkNumber < self.linkDataSource.count) {
        UIImage *image = [UIImage imageNamed:[self.linkDataSource objectAtIndex:_linkNumber]];
        self.linkImgView.image = image;
        _linkNumber++;
    }else {
        self.link.paused = YES;
        [self.link invalidate];
        self.link = nil;
    }
}

@end
