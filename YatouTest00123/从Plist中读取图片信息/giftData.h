//
//  giftData.h
//  AnimationImage
//
//  Created by yizheming on 2016/11/6.
//  Copyright © 2016年 Raymond~. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface giftData : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSNumber *time;

-(id)initWithDictionary:(NSDictionary *)dic;
@end
