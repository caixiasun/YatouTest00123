//
//  GiftView.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "GiftView.h"
#import <Masonry.h>

@implementation GiftShakeLabel

- (void)startAnimWithDuration:(NSTimeInterval)duration {
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(4, 4);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
}

//  重写 drawTextInRect 文字描边效果
- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 5);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = _borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

@end

@interface GiftView()

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy) void(^completeBlock)(BOOL finished,NSInteger finishCount); // 新增了回调参数 finishCount， 用来记录动画结束时累加数量，将来在3秒内，还能继续累加

@end

@implementation GiftView

- (void)animateWithCompleteBlock:(CompleteBlock)completed {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self shakeNumberLabel];
    }];
    self.completeBlock = completed;
}

- (void)shakeNumberLabel{
    _animCount ++;
    
    [self performSelector:@selector(hideGiftView) withObject:nil afterDelay:2];
    
    self.shakeLabel.text = [NSString stringWithFormat:@"X %ld",_animCount];
    [self.shakeLabel startAnimWithDuration:0.3];
}

- (void)hideGiftView {
    [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y - 20, self.frame.size.width, self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.completeBlock) {
            self.completeBlock(finished,_animCount);
        }
        [self reset];
        _finished = finished;
//        [self removeFromSuperview];
    }];
}

// 重置
- (void)reset {
    
    self.frame = _originFrame;
    self.alpha = 1;
    self.animCount = 0;
    self.shakeLabel.text = @"";
}

- (instancetype)init {
    if (self = [super init]) {
        _originFrame = self.frame;
        [self setUI];
    }
    return self;
}

#pragma mark 布局 UI
- (void)layoutSubviews {
    
    [super layoutSubviews];

    _headImgView.layer.cornerRadius = _headImgView.frame.size.height / 2;
    _headImgView.layer.masksToBounds = YES;
    
//    _shakeLabel.frame = CGRectMake(CGRectGetMaxX(self.frame) + 5,-20, 50, 30);
    
}

#pragma mark 初始化 UI
- (void)setUI {
    
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    _deviceImgView = [[UIImageView alloc] init];
    _headImgView = [[UIImageView alloc] init];
    _giftImgView = [[UIImageView alloc] init];
    _levelImgView = [[UIImageView alloc] init];
    _senderNameLabel = [[UILabel alloc] init];
    _giftNameLabel = [[UILabel alloc] init];
    _senderNameLabel.textColor  = [UIColor whiteColor];
    _senderNameLabel.font = [UIFont systemFontOfSize:13];
    _giftNameLabel.textColor  = [UIColor yellowColor];
    _giftNameLabel.font = [UIFont systemFontOfSize:12];
    
    // 初始化动画label
    _shakeLabel =  [[GiftShakeLabel alloc] init];
    _shakeLabel.font = [UIFont systemFontOfSize:20];
    _shakeLabel.borderColor = [UIColor yellowColor];
    _shakeLabel.textColor = [UIColor greenColor];
    _shakeLabel.textAlignment = NSTextAlignmentCenter;
    _animCount = 0;
    
    [self addSubview:_bgImageView];
    [self addSubview:_headImgView];
    [self addSubview:_giftImgView];
    [self addSubview:_senderNameLabel];
    [self addSubview:_giftNameLabel];
    [self addSubview:_shakeLabel];
    [self addSubview:_deviceImgView];
    [self addSubview:_levelImgView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.center.equalTo(self);
    }];
    CGFloat margin = 2;
    [_deviceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 3;
        make.centerY.equalTo(self);
    }];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.centerY.equalTo(self);
        make.left.equalTo(_deviceImgView.mas_right).offset = margin;
    }];
    [_senderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImgView.mas_right).offset = margin;
        make.centerY.equalTo(self);
    }];
    [_levelImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_senderNameLabel.mas_right).offset = margin;
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
        make.width.equalTo(_levelImgView.mas_height).multipliedBy(2);
    }];
    [_giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_levelImgView.mas_right).offset = margin;
        make.centerY.equalTo(self);
    }];
    [_giftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftNameLabel.mas_right).offset = margin;
        make.centerY.equalTo(self);
    }];
    [_shakeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftImgView.mas_right).offset = 2*margin;
        make.centerY.equalTo(self);
    }];
    
}

- (void)setGiftObj:(GiftObj *)giftObj {
    _giftObj = giftObj;
    _deviceImgView.image = giftObj.deviceImage;
    _headImgView.image = giftObj.headImage;
    _giftImgView.image = giftObj.giftImage;
    _levelImgView.image = giftObj.levelImage;
    _senderNameLabel.text = giftObj.name;
    _giftNameLabel.text = [NSString stringWithFormat:@"送出%@",giftObj.giftName];
    _giftCount = giftObj.giftCount;
}

@end
