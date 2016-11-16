//
//  GetPicFromPlistController.m
//  YatouTest00123
//
//  Created by caixiasun on 2016/11/15.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import "GetPicFromPlistController.h"
#import "giftData.h"

@interface GetPicFromPlistController ()

@end

@implementation GetPicFromPlistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"giftlist" ofType:@"plist"];
    NSArray *dics = [[NSArray alloc] initWithContentsOfFile:plistPath];
    giftData *gift = [[giftData alloc] initWithDictionary:dics[0]];
    NSLog(@"_________%@",gift);
}



@end
