//
//  CardStackView.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/3.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "CardStackView.h"
#import "CardView.h"

#define Bottom_CardStackView kScreenHeight-49

@interface CardStackView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *cardViews;
@property (nonatomic, assign) CardViewAnimationStatus animationStatus;

@end

@implementation CardStackView

static const NSInteger CardCount = 6;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.animationStatus = CardViewAnimationStatusAnimateNone;
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.scrollView];
    [self addCardView];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-49)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.width, kScreenHeight);
        _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

- (NSMutableArray *)cardViews {
    if (!_cardViews) {
        _cardViews = [NSMutableArray arrayWithCapacity:CardCount];
    }
    return _cardViews;
}

/**
 初始化：创建CardCount个卡片
 */
- (void)addCardView {
    for (int i=0; i<CardCount; i++) {
        CardView *cardView = [[CardView alloc] init];
        [self.scrollView addSubview:cardView];
        [self.cardViews addObject:cardView];
    }
    //设置卡片的初始位移动画
    [self setCardInitPosition];
}

/**
 卡片最初的状态
 */
- (void)setCardInitPosition {
    __weak typeof(self) weakSelf = self;
    CGFloat originMargin = 30.0;//初始间隔
    CGFloat tempMargin = 10.0;//跳跃间隔
    CGFloat destiMargin = 20.0;//目标间隔  用于做动画
    for (int i=0; i<CardCount; i++) {
        CardView *cardView = self.cardViews[i];
        cardView.centerX = kScreenWidth*0.5;
        if (i<3) {
            if ([cardView isKindOfClass:[CardView class]]) {
                cardView.top = Bottom_CardStackView;//初始位置
                cardView.transform = CGAffineTransformMakeScale(0.5, 0.5);//初始变形
            }
        }else {
            cardView.top = Bottom_CardStackView-(CardCount-i)*originMargin;
            CGFloat scale = 1-(CardCount-i)*0.05;
            cardView.transform = CGAffineTransformMakeScale(scale, scale);
            NSTimeInterval duration = 1.5;
            [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear| UIViewAnimationOptionCurveLinear animations:^{
                [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1/2.0 animations:^{
                    cardView.top = Bottom_CardStackView-(CardCount-i)*tempMargin;
                }];
                [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
                    cardView.top = Bottom_CardStackView-(CardCount-i)*destiMargin;
                }];
            } completion:^(BOOL finished) {
                [weakSelf displayCards];
            }];
        }
    }
}


/**
 初始动画结束后，展示4个card在屏幕上。
 */
- (void)displayCards {
    
    for (int i=0; i<CardCount; i++) {
        CardView *cardView = self.cardViews[i];
        CGFloat scale = 1-(CardCount-i)*0.05;
        [UIView animateWithDuration:0.7 animations:^{
            cardView.transform = CGAffineTransformMakeScale(scale, scale);
            cardView.top = self.centerY-(CardCount-i)*FitHeight(60)-(CardCount-i-1)*20;
        }];
    }
}


#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    CardView *topCardView = self.cardViews[CardCount-1];
    __weak typeof(self) weakSelf = self;
    if (y < 0) {//向下滑
        if (_animationStatus == CardViewAnimationStatusAnimateNone) {
            CGFloat top = topCardView.top + 1;//fabs(y);
            if (top >= kScreenHeight*0.55) {
                //让topCardView渐变消失
                [UIView animateWithDuration:1.0 animations:^{
                    topCardView.top = kScreenHeight;
                    topCardView.alpha = 0;
                } completion:^(BOOL finished) {
                    CardView *tempCardV = _cardViews[CardCount-1];
                    [_cardViews removeLastObject];
                    [_cardViews insertObject:tempCardV atIndex:0];
                    [topCardView removeFromSuperview];
                    [_scrollView insertSubview:topCardView atIndex:0];
                    [weakSelf displayCards];
                }];
            }else {
                //所有Card做位移
                topCardView.top = top;
                _animationStatus = CardViewAnimationStatusAnimating;
            }
        }
        
        NSLog(@"____下滑——————-----______");
    }
}

@end
