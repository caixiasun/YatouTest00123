//
//  GiftObj.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChatMessageObj : NSObject

@property (nonatomic, copy) NSString *senderName;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *senderChatID;

@end

@interface GiftObj : NSObject

@property (nonatomic, strong) UIImage *deviceImage;//设备图标
@property (nonatomic, strong) UIImage *headImage;//头像
@property (nonatomic, strong) UIImage *giftImage;//礼物
@property (nonatomic, strong) UIImage *levelImage;//等级图标
@property (nonatomic, copy) NSString *name;//送礼物者
@property (nonatomic, copy) NSString *giftName;//礼物名称
@property (nonatomic, assign) NSInteger giftCount;//礼物数量

@end
