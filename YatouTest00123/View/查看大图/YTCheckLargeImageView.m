//
//  YTCheckLargeImageView.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/9.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "YTCheckLargeImageView.h"
#import "AppDelegate.h"

@implementation YTCheckLargeImageView

+ (YTCheckLargeImageView *)createWithImage:(UIImage *)image Origin:(CGPoint)origin {
    YTCheckLargeImageView *view = [[YTCheckLargeImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = .8;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    
    view.image = image;
    view.origin = origin;
    [view setupUI];
    
    return view;
}

- (void)setupUI {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGSize size = self.image.size;
    if (size.width > size.height) {
        if (size.width > screenW) {
            size.height = screenW * (size.height/size.width);
            size.width = screenW;
        }else if (size.height > screenH) {
            size.width = screenH * (size.width/size.height);
            size.height = screenH;
        }
    }else {
        if (size.height > screenH) {
            size.width = screenH * (size.width/size.height);
            size.height = screenH;
        }else if (size.width > screenW) {
            size.height = screenW * (size.height/size.width);
            size.width = screenW;
        }
    }
    
    UIImageView *imgView = [UIImageView new];
    imgView.frame = CGRectMake(self.origin.x, self.origin.y, size.width, size.height);
    imgView.image = self.image;
    [self addSubview:imgView];
    
    [UIView animateWithDuration:.3 animations:^{
        imgView.center = self.center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            imgView.transform = CGAffineTransformScale(imgView.transform, .7, .7);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                imgView.transform = CGAffineTransformScale(imgView.transform, 1.3, 1.3);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.3 animations:^{
                    imgView.transform = CGAffineTransformScale(imgView.transform, 1.0, 1.0);
                }];
            }];
        }];
    }];
}

- (void)tapAction {
    [self hide];
}

- (void)hide {
    [self removeFromSuperview];
}

@end
