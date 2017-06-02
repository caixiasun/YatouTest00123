//
//  CardViewController.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/7.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetCard.h"

@interface CardViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic, strong) PetCard *petCard;

@end
