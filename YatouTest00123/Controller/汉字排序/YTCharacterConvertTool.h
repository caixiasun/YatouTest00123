//
//  CharacterConvertTool.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/6.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTCharacterConvertTool : NSObject

/**
 对一个汉字数组排序

 @param characterArray 需要排序的汉字数组
 @return 排序后的汉字数组
 */
+ (NSArray *)sortedChineseCharacter:(NSArray *)chineseArray;

@end

@interface YTCharacterConvertObj : NSObject

@property (nonatomic, strong) NSString *chinese;
@property (nonatomic, strong) NSString *pinyin;

- (instancetype)initWithChinese:(NSString *)chinese Pinyin:(NSString *)pinyin;

@end
