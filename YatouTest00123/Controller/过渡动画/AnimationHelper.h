//
//  AnimationHelper.h
//  YatouTest00123
//
//  Created by caixiasun on 2017/2/7.
//  Copyright © 2017年 yatou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationHelper : NSObject

+ (CATransform3D)yRotation:(CGFloat)angle;
+ (void)persipectiveTransformForContainerView:(UIView *)containerView;


@end
