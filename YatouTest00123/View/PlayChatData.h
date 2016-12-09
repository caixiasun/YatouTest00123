//
//  PlayChatData.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayChatData : NSObject

@property (nonatomic, strong) NSString *deviceImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *hostImage;
@property (nonatomic, strong) NSString *levelImage;
@property (nonatomic, strong) NSString *content;

+ (PlayChatData *)initWithDeviceImage:(NSString *)deviceImage Name:(NSString *)name HostImage:(NSString *)hostImage LevelImage:(NSString *)levelImage Content:(NSString *)content;

@end
