//
//  PlayChatCell.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit.h>
#import "PlayChatData.h"

@interface PlayChatCellLayout : NSObject

@property (nonatomic, strong) UIImageView *deviceImageView;//设备图标
@property (nonatomic, strong) YYTextLayout *textLayout;     /// 名字、等级图标、聊天内容
@property (nonatomic, strong) PlayChatData *data;
@property (nonatomic, assign) CGFloat height;


- (instancetype)initWithData:(PlayChatData *)data Cell_width:(CGFloat)width;

@end

@interface PlayChatCell : UITableViewCell

@property (nonatomic, strong) UIImageView *deviceImageView;
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, assign) CGFloat cHeight;
@property (nonatomic, strong) PlayChatCellLayout *layout;

@end
