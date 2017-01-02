//
//  PlayChatData.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "PlayChatData.h"

@implementation PlayChatData

+ (PlayChatData *)initWithDeviceImage:(NSString *)deviceImage Name:(NSString *)name HostImage:(NSString *)hostImage LevelImage:(NSString *)levelImage Content:(NSString *)content {
    PlayChatData *data = [PlayChatData new];
    data.deviceImage = deviceImage;
    data.name = name;
    data.hostImage = hostImage;
    data.levelImage = levelImage;
    data.content = content;
    return data;
}

@end
