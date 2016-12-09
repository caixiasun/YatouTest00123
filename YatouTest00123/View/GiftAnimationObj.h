//
//  GiftAnimationObj.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiftView.h"

@interface GiftAnimationObj : NSObject


@property (nonatomic, strong) GiftView *giftView;
@property (nonatomic, strong) GiftObj *giftObj;
@property (nonatomic, strong) UIView *parentView;



// 回调参数增加了结束时礼物累计数
+ (instancetype)animOperationWithUserID:(NSString *)userID GiftObj:(GiftObj *)giftObj finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock;

- (void)startAnimation;
- (void)cancelAnimation;

@end
