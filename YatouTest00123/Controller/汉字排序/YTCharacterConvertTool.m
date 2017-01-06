//
//  CharacterConvertTool.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/1/6.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "YTCharacterConvertTool.h"

@implementation YTCharacterConvertTool

//将汉字转换成对应的拼音
+ (NSMutableString *)convertCharacterToPinyin:(NSString *)convertString {
    //转换成拼音
    NSMutableString *mutableString = [NSMutableString stringWithString:convertString];
    CFStringTransform((CFMutableStringRef) mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef) mutableString, NULL, kCFStringTransformStripDiacritics, false);
    //去掉字符间的空格
    mutableString = (NSMutableString *)[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return mutableString;
}
//将汉字数组转成拼音数组
+ (NSArray *)convertChineseCharacterArrayToPinyinArray:(NSArray *)convertArray {
    NSMutableArray *pinyinArray = [NSMutableArray new];
    for (NSString *chineseString in convertArray) {
        NSString *pinyin = [self convertCharacterToPinyin:chineseString];
        YTCharacterConvertObj *obj = [[YTCharacterConvertObj alloc] initWithChinese:chineseString Pinyin:pinyin];
        [pinyinArray addObject:obj];
    }
    return [pinyinArray copy];
}

+ (NSArray *)sortedChineseCharacter:(NSArray *)chineseArray {
    NSArray *sortDescriptorts = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    NSArray *pinyinArray = [self convertChineseCharacterArrayToPinyinArray:chineseArray];
    return [pinyinArray sortedArrayUsingDescriptors:sortDescriptorts];
}

@end

@implementation YTCharacterConvertObj

- (instancetype)initWithChinese:(NSString *)chinese Pinyin:(NSString *)pinyin {
    YTCharacterConvertObj *obj = [YTCharacterConvertObj new];
    obj.chinese = chinese;
    obj.pinyin = pinyin;
    return obj;
}

@end
