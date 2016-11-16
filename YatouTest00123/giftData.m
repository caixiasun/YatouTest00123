//
//  giftData.m
//  AnimationImage
//
//  Created by yizheming on 2016/11/6.
//  Copyright © 2016年 Raymond~. All rights reserved.
//

#import "giftData.h"

@implementation giftData
-(id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    _name = [dic valueForKey:@"name"];
    _time = [dic valueForKey:@"time"];
    _num = [dic valueForKey:@"num"];
    return self;
}
@end
