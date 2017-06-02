//
//  CardStackView.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/3.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CardViewAnimationStatusAnimateNone,
    CardViewAnimationStatusAnimating,
    CardViewAnimationStatusAnimateStop
} CardViewAnimationStatus;

@interface CardStackView : UIView

@end
