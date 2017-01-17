//
//  YTBlock.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/17.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VoidBlock)();
typedef void(^ChangeBackColorBlock)(UIColor *color);

@interface YTBlock : NSObject

@property (nonatomic, strong) VoidBlock voidBlock;
@property (nonatomic, strong) ChangeBackColorBlock changeBackColorBlock;

+ (YTBlock *)sharedInstance;
- (void)callVoidBlock;
- (void)callChangeBackColorBlock;

@end
