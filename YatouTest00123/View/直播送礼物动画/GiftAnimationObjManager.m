//
//  GiftAnimationObjManager.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "GiftAnimationObjManager.h"

#define Height_GiftView 40
#define Width_GiftView self.parentView.frame.size.width * 0.5

@interface GiftAnimationObjManager()

@property (nonatomic, assign) NSInteger count;
/// 操作缓存池
@property (nonatomic,strong) NSCache *operationCache;
/// 维护用户礼物信息
@property (nonatomic,strong) NSCache *userGigtInfos;

@end

@implementation GiftAnimationObjManager

+ (instancetype)sharedAnimationManager {
    static GiftAnimationObjManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GiftAnimationObjManager alloc] init];
        manager.count = 0;
    });
    return manager;
}

- (void)animWithUserID:(NSString *)userID GiftObj:(GiftObj *)giftObj finishedBlock:(void(^)(BOOL result))finishedBlock {
    //在有用户礼物信息时
    if ([self.userGigtInfos objectForKey:userID]) {
        // 如果有操作缓存，则直接累加，不需要重新创建op
        if ([self.operationCache objectForKey:userID] != nil) {
            GiftAnimationObj *animObj = [self.operationCache objectForKey:userID];
            animObj.giftView.giftCount = giftObj.giftCount;
            [animObj.giftView shakeNumberLabel];
            return ;
        }
        //没有操作，创建
        GiftAnimationObj *animObj = [GiftAnimationObj animOperationWithUserID:userID GiftObj:giftObj finishedBlock:^(BOOL result, NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userID];
            });
        }];
        animObj.giftView.animCount = [[self.userGigtInfos objectForKey:userID] integerValue];
        animObj.giftObj.giftCount = animObj.giftView.animCount+1;
        animObj.parentView = self.parentView;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:animObj forKey:userID];
        
        if ([userID integerValue] == 0) {
            if (animObj.giftObj.giftCount != 0) {
                animObj.giftView.frame = CGRectMake(-self.parentView.frame.size.width / 2, 300, Width_GiftView, Height_GiftView);
                animObj.giftView.originFrame = animObj.giftView.frame;
            }
        }else {
            if (animObj.giftObj.giftCount != 0) {
                animObj.giftView.frame = CGRectMake(-self.parentView.frame.size.width / 2, 240, Width_GiftView, Height_GiftView);
                animObj.giftView.originFrame = animObj.giftView.frame;
            }
        }
        [animObj startAnimation];
        
    }else{//在没有用户礼物信息时
        //如果已经存在该操作，则直接累加，不再重新创建
        if ([self.operationCache objectForKey:userID] != nil) {
            GiftAnimationObj *animObj = [self.operationCache objectForKey:userID];
            animObj.giftView.giftCount = giftObj.giftCount;
            [animObj.giftView shakeNumberLabel];
            return ;
        }
        //不存在该操作，直接创建
        GiftAnimationObj *animObj = [GiftAnimationObj animOperationWithUserID:userID GiftObj:giftObj finishedBlock:^(BOOL result, NSInteger finishCount) {
            // 回调
            if (finishedBlock) {
                finishedBlock(result);
            }
            
            // 将礼物信息数量存起来
            [self.userGigtInfos setObject:@(finishCount) forKey:userID];
            // 动画完成之后,要移除动画对应的操作
            [self.operationCache removeObjectForKey:userID];
            // 延时删除用户礼物信息
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.userGigtInfos removeObjectForKey:userID];
            });
        }];
        
        animObj.parentView = self.parentView;
        
        // 将操作添加到缓存池
        [self.operationCache setObject:animObj forKey:userID];
        
        if ([userID integerValue] == 0) {
            if (animObj.giftObj.giftCount != 0) {
                animObj.giftView.frame = CGRectMake(-self.parentView.frame.size.width / 2, 300, Width_GiftView, Height_GiftView);
                animObj.giftView.originFrame = animObj.giftView.frame;
            }
        }else {
            if (animObj.giftObj.giftCount != 0) {
                animObj.giftView.frame = CGRectMake(-self.parentView.frame.size.width / 2, 240, Width_GiftView, Height_GiftView);
                animObj.giftView.originFrame = animObj.giftView.frame;
            }
        }
        [animObj startAnimation];
        
        
    }
    
}

- (NSCache *)operationCache
{
    if (_operationCache==nil) {
        _operationCache = [[NSCache alloc] init];
    }
    return _operationCache;
}

- (NSCache *)userGigtInfos {
    if (_userGigtInfos == nil) {
        _userGigtInfos = [[NSCache alloc] init];
    }
    return _userGigtInfos;
}

@end
