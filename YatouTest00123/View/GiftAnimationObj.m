//
//  GiftAnimationObj.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "GiftAnimationObj.h"

@interface GiftAnimationObj()

@property (nonatomic, getter = isFinished)  BOOL finished;
@property (nonatomic, getter = isAnimating) BOOL animating;
@property (nonatomic,copy) void(^finishedBlock)(BOOL result,NSInteger finishCount);

@end

@implementation GiftAnimationObj

+ (instancetype)animOperationWithUserID:(NSString *)userID GiftObj:(GiftObj *)giftObj finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock {
    GiftAnimationObj *obj = [[GiftAnimationObj alloc] init];
    obj.giftView = [[GiftView alloc] init];
    obj.giftObj = giftObj;
    obj.finishedBlock = finishedBlock;
    return obj;
}

- (void)startAnimation {
    self.animating = YES;
    _giftView.giftObj = _giftObj;
    _giftView.originFrame = _giftView.frame;
    [self.parentView addSubview:_giftView];
    [self.giftView animateWithCompleteBlock:^(BOOL finished, NSInteger finishCount) {
        self.finished = finished;
        self.finishedBlock(finished, finishCount);
    }];
}

- (void)cancelAnimation {
    self.animating = NO;
    self.finished = YES;
    self.finishedBlock(YES,0);
}

#pragma mark -  手动触发 KVO
- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setAnimating:(BOOL)animating {
    [self willChangeValueForKey:@"isAnimating"];
    _animating = animating;
    [self didChangeValueForKey:@"isAnimating"];
}

@end
