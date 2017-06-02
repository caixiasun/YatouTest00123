//
//  RuntimeDemo.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/9.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolTest;
@interface RuntimeClass : NSObject<ProtocolTest,NSCoding>
{
    int count;
    NSArray *_testArray;
}

@property (nonatomic, assign) BOOL isFunll;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *idendifier;

- (void)run;
- (void)eat:(NSString *)eat;
- (BOOL)isEmpty;
- (void)myTest;

@end

@protocol ProtocolTest <NSObject>

@optional

@end
