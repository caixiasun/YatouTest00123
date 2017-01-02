//
//  GiftAnimationObjManager.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiftAnimationObj.h"

@interface GiftAnimationObjManager : NSObject

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) GiftObj *giftObj;

+ (instancetype)sharedAnimationManager;
/// 动画操作 : 需要UserID和回调
- (void)animWithUserID:(NSString *)userID GiftObj:(GiftObj *)giftObj finishedBlock:(void(^)(BOOL result))finishedBlock;

@end
