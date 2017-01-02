//
//  YTCheckLargeImageView.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/9.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTCheckLargeImageView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGPoint origin;

+ (YTCheckLargeImageView *)createWithImage:(UIImage *)image Origin:(CGPoint)origin;

@end
