//
//  PlaySendGiftController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "PlaySendGiftController.h"
#import "GiftAnimationObjManager.h"

@interface PlaySendGiftController ()

@end

@implementation PlaySendGiftController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ChatMessageObj *messageObj = [[ChatMessageObj alloc] init];
    messageObj.text = @"1个 【鲜花】";
    //模拟N个人在送礼物
    int x = arc4random() % 2;
    messageObj.senderName = @"Lena";
    messageObj.senderChatID = [NSString stringWithFormat:@"%d",x];
    
    GiftObj *giftObj = [[GiftObj alloc] init];
    giftObj.deviceImage = [UIImage imageNamed:@"computer.png"];
    giftObj.headImage = [UIImage imageNamed:@"head.png"];
    giftObj.name = messageObj.senderName;
    giftObj.levelImage = [UIImage imageNamed:@"wealth_level.png"];
    giftObj.giftName = messageObj.text;
    giftObj.giftImage = [UIImage imageNamed:@"ping_large.png"];
    
    giftObj.giftCount = 1;
    
    GiftAnimationObjManager *manager = [GiftAnimationObjManager sharedAnimationManager];
    manager.parentView = self.view;
    [manager animWithUserID:[NSString stringWithFormat:@"%@",messageObj.senderChatID] GiftObj:giftObj finishedBlock:^(BOOL result) {
        NSLog(@"completed....");
    }];
}

@end
