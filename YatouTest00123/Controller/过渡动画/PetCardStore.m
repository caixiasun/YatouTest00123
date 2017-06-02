//
//  PetCardStore.m
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/7.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import "PetCardStore.h"
#import "PetCard.h"
#import <UIKit/UIkit.h>

@implementation PetCardStore

+ (NSArray *)defaultPets {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Pets" ofType:@"plist"];
    NSDictionary *dictionay = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSArray *petData = dictionay[@"Pets"];
    NSMutableArray *pets = [[NSMutableArray alloc] init];
    
    for (NSDictionary *data in petData) {
        PetCard *petcard = [[PetCard alloc] init];
        petcard.name = data[@"name"];
        petcard.desc = data[@"description"];
        petcard.image = [UIImage imageNamed:data[@"image"]];
        [pets addObject:petcard];
    }
    return pets;
}

@end
