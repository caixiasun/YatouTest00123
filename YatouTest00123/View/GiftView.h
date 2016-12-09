//
//  GiftView.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftObj.h"

@interface GiftShakeLabel : UILabel

// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;
// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;

- (void)startAnimWithDuration:(NSTimeInterval)duration;

@end

typedef void(^CompleteBlock)(BOOL finished, NSInteger finishCount);

@interface GiftView : UIView

@property (nonatomic, strong) GiftObj *giftObj;
@property (nonatomic, strong) UIImageView *deviceImgView;//终端设备图标
@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UIImageView *giftImgView;
@property (nonatomic, strong) UIImageView *levelImgView;//等级图标
@property (nonatomic,strong) UILabel *senderNameLabel; // 送礼物者
@property (nonatomic,strong) UILabel *giftNameLabel; // 礼物名称
@property (nonatomic,assign) NSInteger giftCount; // 礼物个数

@property (nonatomic,strong) GiftShakeLabel *shakeLabel;
@property (nonatomic,assign) NSInteger animCount; // 动画执行到了第几次
@property (nonatomic,assign) CGRect originFrame; // 记录原始坐标
@property (nonatomic,assign,getter=isFinished) BOOL finished;

- (void)animateWithCompleteBlock:(CompleteBlock)completed;


- (void)shakeNumberLabel;
- (void)hideGiftView;

@end
